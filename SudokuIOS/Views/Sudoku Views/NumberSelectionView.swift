//
//  NumberSelection.swift
//  SudokuIOS
//
//  Created by Simone Samardzhiev on 14.07.24.
//

import SwiftUI


/// View used to select the numbers in the sudoku.
struct NumberSelectionView: View {
    /// The manager of the sudoku.
    @EnvironmentObject var sudokuManager: SudokuManager
    /// The width of the number selection.
    let size: CGFloat
    
    /// Initialiser of the number selection view.
    /// - Parameter size: The width of the number selection.
    init(size: CGFloat) {
        self.size = size
    }
    
    var body: some View {
        HStack {
            ForEach(1..<10) { number in
                Spacer()
                Button {
                    
                } label: {
                    Text(String(number))
                        .foregroundStyle(Color.blue)
                        .font(Font.system(size: size / 10))
                }
                Spacer()
            }
        }
        .padding()
    }
}
