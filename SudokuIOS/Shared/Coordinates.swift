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
    
    /// Method that will return a randomly generated coordinates.
    /// - Parameter range: The range of the coordinates.
    /// - Returns: The generated coordinates.
    static func generateRandomCoordinates(range: Range<Int>) -> Coordinates {
        let row = Int.random(in: range)
        let col = Int.random(in: range)
        
        return Coordinates(row: row, col: col)
    }
}
