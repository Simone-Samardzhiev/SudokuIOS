//
//  BoardView.swift
//  SudokuIOS
//
//  Created by Simone Samardzhiev on 14.07.24.
//

import SwiftUI


/// Board view used to display the sudoku.
struct BoardView: View {
    /// The manager of the sudoku.
    @EnvironmentObject var sudokuManager: SudokuManager
    /// The size of the board.
    let size: CGFloat
    
    /// Initializer of the board view.
    /// - Parameter size: The size of the board.
    init(size: CGFloat) {
        self.size = size
    }
    
    var body: some View {
        Rectangle()
            .stroke()
            .frame(width: size, height: size)
            .background(alignment: .center) {
                VStack(spacing: 0) {
                    ForEach(0..<3) { i in
                        HStack(spacing: 0) {
                            ForEach(0..<3) { j in
                                BoxView(
                                    x: i,
                                    y: j
                                )
                            }
                        }
                    }
                }
            }
    }
}
