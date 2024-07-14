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
    /// The coordinates of the cell.
    let coordinates: Coordinates
    
    /// Initializer of the cell view.
    /// - Parameter coordinates: The coordinates of the cell.
    init(coordinates: Coordinates) {
        self.coordinates = coordinates
    }
    
    var body: some View {
        Button {
            
        } label: {
            Rectangle()
                .stroke(Color.gray, lineWidth: 1)
                .overlay(alignment: .center) {
                    if let num = sudokuManager.numbers[coordinates.row][coordinates.col].value {
                        Text(String(num))
                            .foregroundStyle(
                                sudokuManager.numbers[coordinates.row][coordinates.col].isGenerated ? Color.generatedNumber : Color.blue
                            )
                            .bold(
                                sudokuManager.numbers[coordinates.row][coordinates.col].isGenerated
                            )
                    }
                }
        }
    }
}
