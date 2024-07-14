//
//  SudokuManager.swift
//  SudokuIOS
//
//  Created by Simone Samardzhiev on 12.07.24.
//

import Foundation

/// Struct used to create the numbers of the sudoku.
struct SudokuNumber {
    /// The value of the number.
    var value: Int?
    /// Bool variable representing if the number is generated or inputed by the user.
    var isGenerated: Bool
    /// Bool variable representing if the number should be generated.
    var isHighlighted: Bool
    
    /// Default constructor.
    init() {
        self.value = nil
        self.isGenerated = true
        self.isHighlighted = false
    }
}

/// Enumeration used to select the difficulty of the sudoku.
enum SudokuDifficulty: String {
    case easy
    case normal
    case hard
}

/// Class that will manage the sudoku.
class SudokuManager: ObservableObject {
    /// Two demential array keeping the numbers.
    @Published var numbers: [[SudokuNumber]]
    /// Variable keeping the difficulty.
    @Published var difficulty: SudokuDifficulty
    /// Bool variable representing if the game is started or not.
    @Published var gameStarted: Bool
    /// Variable keeping the selected number.
    @Published var selectedNumber: Int?
    
    /// Default initializer.
    init() {
        self.numbers = Array(repeating: Array(repeating: SudokuNumber(), count: 9), count: 9)
        self.difficulty = .easy
        self.gameStarted = false
        self.selectedNumber = nil
    }
    
    /// Method that will find an empty cell.
    /// - Returns: The coordinates of the empty cell in a tuple or nil if there is not an empty cell.
    private func findEmptyCell() -> (Int, Int)? {
        for i in 0..<9 {
            for j in 0..<9 {
                if numbers[i][j].value == nil {
                    return (i, j)
                }
            }
        }
        
        return nil
    }
    
    /// Method that will check if a value can be placed in a cell.
    /// - Parameters:
    ///   - row: The row of the cell.
    ///   - col: The column of the cell.
    ///   - value: The value that has to be placed.
    /// - Returns: True if the number can be placed otherwise false.
    private func isSafe(row: Int, col: Int, value: Int) -> Bool {
        for i in 0..<9 {
            if numbers[row][i].value == value || numbers[i][col].value == value {
                return false
            }
        }
        
        let x = row - row % 3
        let y = col - col % 3
        
        for i in 0..<3 {
            for j in 0..<3 {
                if numbers[i + x][j + y].value == value {
                    return false
                }
            }
        }
        
        return true
    }
    
    /// Method that will try to solve the sudoku.
    /// - Returns: True if the sudoku is solvable otherwise false.
    private func solve() -> Bool {
        guard let (row, col) = findEmptyCell() else {
            return true
        }
        
        for num in [1, 2, 3, 4, 5, 6, 7, 8, 9].shuffled() {
            if isSafe(row: row, col: col, value: num) {
                numbers[row][col].value = num
                
                if solve() {
                    return true
                }
                
                numbers[row][col].value = nil
            }
        }
        
        return false
    }
    
    /// Method that will remove random numbers form the sudoku based on the difficulty.
    private func removeNumbers() {
        var count: Int
        
        switch difficulty {
        case .easy:
            count = 30
        case .normal:
            count = 40
        case .hard:
            count = 50
        }
        
        while count > 0 {
            let row = Int.random(in: 0..<9)
            let col = Int.random(in: 0..<9)
            
            if numbers[row][col].value != nil {
                numbers[row][col].value = nil
                count -= 1
            }
        }
    }
    
    /// Method that will clear all the numbers.
    private func clearNumbers() {
        for i in 0..<9 {
            for j in 0..<9 {
                numbers[i][j].value = nil
                numbers[i][j].isGenerated = true
                numbers[i][j].isHighlighted = false
            }
        }
    }
    
    /// Method that will start the game.
    func startGame() {
        // The result is not used, because the sudoku is empty so it can always be solved.
        _ = solve()
        removeNumbers()
        gameStarted = true
    }
    
    func endGame() {
        clearNumbers()
        gameStarted = false
        selectedNumber = nil
    }
    
    /// Method that will be called when a new number is selected.
    /// - Parameter newNumber: The new selected number.
    func onSelectedNumber(newNumber: Int) {
        for i in 0..<9 {
            for j in 0..<9 {
                if numbers[i][j].value == newNumber {
                    numbers[i][j].isHighlighted = true
                } else {
                    numbers[i][j].isHighlighted = false
                }
            }
        }
        
        selectedNumber = newNumber
    }
    
    /// Class that will check the sudoku each time a number is inputed.
    class SudokuChecker {
        /// Array keeping the sudoku that has to be checked.
        private var sudokuToCheck: [[Int?]]
        /// Singleton.
        static let shared = SudokuChecker()
        
        /// Default initializer.
        init() {
            self.sudokuToCheck = []
        }
        
        /// Method that will find an empty cell.
        /// - Returns: The coordinates of the empty cell. If there aren't any the method will return nil.
        private func findEmptyCell() -> (Int, Int)? {
            for i in 0..<9 {
                for j in 0..<9 {
                    if sudokuToCheck[i][j] == nil {
                        return (i, j)
                    }
                }
            }
            
            return nil
        }
    }
}
