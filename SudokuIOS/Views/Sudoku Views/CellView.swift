//
//  CellView.swift
//  SudokuIOS
//
//  Created by Simone Samardzhiev on 14.07.24.
//

import SwiftUI


/// View that will display each cell of the sudoku.
struct CellView: View {
    /// The manager of the sudoku.
    @EnvironmentObject var sudokuManager: SudokuManager
    /// The x coordinate of the cell.
    let x: Int
    /// The y coordinate of the cell.
    let y: Int
    
    /// Initialiser of the cell view.
    /// - Parameters:
    ///   - x: Teh x coordinate of the cell.
    ///   - y: The y coordinate of the cell.
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    var body: some View {
        Button {
            
        } label: {
            Rectangle()
                .stroke(Color.gray, lineWidth: 1)
                .overlay(alignment: .center) {
                    if let num = sudokuManager.numbers[x][y].value {
                        Text(String(num))
                            .bold(sudokuManager.numbers[x][y].isGenerated)
                    }
                }
        }
    }
}
