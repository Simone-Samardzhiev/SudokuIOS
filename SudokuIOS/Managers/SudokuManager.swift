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
}
