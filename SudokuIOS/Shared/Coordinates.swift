//
//  Coordinates.swift
//  SudokuIOS
//
//  Created by Simone Samardzhiev on 14.07.24.
//

import Foundation

/// Struct used to store a coordinates.
struct Coordinates {
    /// The row  or the x coordinate.
    let row: Int
    /// The column of y coordinate.
    let col: Int
    
    /// Initializer of the coordinates.
    /// - Parameters:
    ///   - row: The row  or the x coordinate.
    ///   - col: The column of y coordinate.
    init(row: Int, col: Int) {
        self.row = row
        self.col = col
    }
    
    
}
