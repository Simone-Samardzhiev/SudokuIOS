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
            if numbers[row][i].value == value || numbers[col][i].value == value {
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
}
