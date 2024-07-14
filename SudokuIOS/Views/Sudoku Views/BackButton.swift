//
//  BackButton.swift
//  SudokuIOS
//
//  Created by Simone Samardzhiev on 13.07.24.
//

import SwiftUI

/// Button used to return form the main view
struct BackButton: View {
    /// The manager of the sudoku.
    @EnvironmentObject var sudokuManager: SudokuManager

    var body: some View {
        Button {
            sudokuManager.endGame()
        } label: {
            Image(systemName: "arrowshape.backward")
                .foregroundStyle(Color.primary)
        }

    }
}
