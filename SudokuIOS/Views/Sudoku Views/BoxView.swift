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
    /// The x coordinate of the box.
    let x: Int
    /// The y coordinate of the box.
    let y: Int
    
    /// Initialiser of the box view.
    /// - Parameters:
    ///   - x: The x coordinate of the box.
    ///   - y: Тhe y coordinate of the box.
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
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
                                    x: x * 3 + i,
                                    y: y * 3 + j
                                )
                            }
                        }
                    }
                }
            }
    }
}
