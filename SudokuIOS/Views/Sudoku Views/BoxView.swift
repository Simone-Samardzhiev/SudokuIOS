//
//  BoxView.swift
//  SudokuIOS
//
//  Created by Simone Samardzhiev on 14.07.24.
//

import SwiftUI


/// View that will display each 9 sub grids in the board.
struct BoxView: View {
    /// The manager of the sudoku.
    @EnvironmentObject var sudokuManager: SudokuManager
    /// The coordinates of the box.
    let coordinates: Coordinates
    
    /// Initializer of the box view.
    /// - Parameter coordinates: The coordinates of the box.
    init(coordinates: Coordinates) {
        self.coordinates = coordinates
    }
    
    var body: some View {
        Rectangle()
            .stroke(Color.primary, lineWidth: 3)
            .background(alignment: .center) {
                VStack(spacing: 0) {
                    ForEach(0..<3) { i in
                        HStack(spacing: 0) {
                            ForEach(0..<3) { j in
                                CellView(
                                    coordinates: Coordinates(
                                        row: coordinates.row * 3 + i,
                                        col: coordinates.col * 3 + j
                                    )
                                )
                            }
                        }
                    }
                }
            }
    }
}
