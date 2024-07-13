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
    /// Two dementional array keeping the numbers.
    @Published var numbers: [[SudokuNumber]]
    /// Variable keeping the difficulty.
    @Published var difficulty: SudokuDifficulty
    /// Bool variable respresenting if the game is started ot not.
    @Published var gameStarted: Bool
    
    /// Default initialser.
    init() {
        self.numbers = Array(repeating: Array(repeating: SudokuNumber(), count: 9), count: 9)
        self.difficulty = .easy
    }
    
    /// Method that will find an empty cell.
    /// - Returns: The coordinated of the empty cell in a tuple or nil if there is not an emoty cell.
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
    
    /// Method that will check if a value can be place in a cell.
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
    private func sole() -> Bool {
        guard let (row, col) = findEmptyCell() else {
            return true
        }
        
        for num in [1, 2, 3, 4, 5, 6, 7, 8, 9].shuffled() {
            if isSafe(row: row, col: col, value: num) {
                numbers[row][col].value = num
                
                if sole() {
                    return true
                }
                
                numbers[row][col].value = nil
            }
        }
        
        return false
    }
    
    /// Method that will remove random nubers form the sudoku based on the difficulty.
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
        // The result is not used, bacause the sudoku is empty so it can always be solved.
        _ = sole()
        clearNumbers()
        gameStarted = true
    }
}
