//
//  SudokuView.swift
//  SudokuIOS
//
//  Created by Simone Samardzhiev on 13.07.24.
//

import SwiftUI


/// Struct that will display the sudoku.
struct SudokuView: View {
    var body: some View {
        GeometryReader { geo in
            VStack {
                
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    BackButton()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
