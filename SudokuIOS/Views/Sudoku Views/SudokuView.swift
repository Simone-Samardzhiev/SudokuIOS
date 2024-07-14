//
//  SudokuView.swift
//  SudokuIOS
//
//  Created by Simone Samardzhiev on 13.07.24.
//

import SwiftUI


/// Struct that will display the sudoku.
struct SudokuView: View {
    /// The manager of the sudoku.
    @EnvironmentObject var sudokuManager: SudokuManager
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                BoardView(size: geo.size.width / 1.1)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    BackButton()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarBackButtonHidden()
        }   
    }
}
