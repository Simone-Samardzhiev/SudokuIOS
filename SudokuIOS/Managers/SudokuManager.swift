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
    /// Variable keeping the count of the mistakes.
    var mistakesCount: Int
    /// Bool variable representing if an alert for wring number should be presented.
    @Published var errorAlertPresent: Bool
    
    /// Default initializer.
    init() {
        self.numbers = Array(repeating: Array(repeating: SudokuNumber(), count: 9), count: 9)
        self.difficulty = .easy
        self.gameStarted = false
        self.selectedNumber = nil
        self.mistakesCount = 0
        self.errorAlertPresent = false
    }
    
    /// Method that will find an empty cell.
    /// - Returns: The coordinates of the empty cell in a tuple or nil if there is not an empty cell.
    private func findEmptyCell() -> Coordinates? {
        for i in 0..<9 {
            for j in 0..<9 {
                if numbers[i][j].value == nil {
                    return Coordinates(row: i, col: j)
                }
            }
        }
        
        return nil
    }
    
    /// Method that will check if a value can be placed in a cell.
    /// - Parameters:
    ///   - coordinates: The coordinates of the cell.
    ///   - value: The value that has to be placed.
    /// - Returns: True if the number can be placed otherwise false.
    private func isSafe(coordinates: Coordinates, value: Int) -> Bool {
        for i in 0..<9 {
            if numbers[coordinates.row][i].value == value || numbers[i][coordinates.col].value == value {
                return false
            }
        }
        
        let x = coordinates.row - coordinates.row % 3
        let y = coordinates.col - coordinates.col % 3
        
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
        guard let coordinates = findEmptyCell() else {
            return true
        }
        
        for num in [1, 2, 3, 4, 5, 6, 7, 8, 9].shuffled() {
            if isSafe(coordinates: coordinates, value: num) {
                numbers[coordinates.row][coordinates.col].value = num
                
                if solve() {
                    return true
                }
                
                numbers[coordinates.row][coordinates.col].value = nil
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
            let coordinates = Coordinates.generateRandomCoordinates(range: 0..<9)
            
            if numbers[coordinates.row][coordinates.col].value != nil {
                numbers[coordinates.row][coordinates.col].value = nil
                numbers[coordinates.row][coordinates.col].isGenerated = false
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
        mistakesCount = 3
    }
    
    /// Method that will end the game.
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
    private class SudokuChecker {
        /// Array keeping the sudoku that has to be checked.
        private var sudokuToCheck: [[Int?]]
        /// Singleton.
        static let shared = SudokuChecker()
        
        /// Default initializer.
        init() {
            self.sudokuToCheck = []
        }
        
        /// Method that will find an empty cell.
        /// - Returns: The coordinates of the empty cell in a tuple or nil if there is not an empty cell.
        private func findEmptyCell() -> Coordinates? {
            for i in 0..<9 {
                for j in 0..<9 {
                    if sudokuToCheck[i][j] == nil {
                        return Coordinates(row: i, col: j)
                    }
                }
            }
            
            return nil
        }
        
        /// Method that will check if a value can be placed in a cell.
        /// - Parameters:
        ///   - coordinates: The coordinates of the cell.
        ///   - value: The value that has to be placed.
        /// - Returns: True if the number can be placed otherwise false.
        private func isSafe(coordinates: Coordinates, value: Int) -> Bool {
            for i in 0..<9 {
                if sudokuToCheck[coordinates.row][i] == value || sudokuToCheck[i][coordinates.col] == value {
                    return false
                }
            }
            
            let x = coordinates.row - coordinates.row % 3
            let y = coordinates.col - coordinates.col % 3
            
            for i in 0..<3 {
                for j in 0..<3 {
                    if sudokuToCheck[x + i][y + j] == value {
                        return false
                    }
                }
            }
            
            return true
        }
        
        /// Method that will try to solve the sudoku.
        /// - Returns: True if it can be solved otherwise false.
        private func tryToSolve() -> Bool {
            guard let coordinates = findEmptyCell() else {
                return true
            }
            
            for num in 1...9 {
                if isSafe(coordinates: coordinates, value: num) {
                    sudokuToCheck[coordinates.row][coordinates.col] = num
                    
                    if (tryToSolve()) {
                        return true
                    }
                    
                    sudokuToCheck[coordinates.row][coordinates.col] = nil
                }
            }
            
            return false
        }
        
        /// Method that will check the sudoku.
        /// - Parameter sudoku: The sudoku that will be checked.
        /// - Returns: True if it can be solved otherwise false.
        func check(sudoku: [[SudokuNumber]]) -> Bool {
            sudokuToCheck = []
            
            for row in sudoku {
                var newRow: [Int?] = []
                for sudokuNumber in row {
                    newRow.append(sudokuNumber.value)
                }
                sudokuToCheck.append(newRow)
            }
            
            return tryToSolve()
        }
    }
}
