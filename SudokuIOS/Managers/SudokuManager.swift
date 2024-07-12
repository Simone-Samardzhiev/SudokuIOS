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

/// Class that will manage the sudoku.
class SudokuManager: ObservableObject {
    
}
