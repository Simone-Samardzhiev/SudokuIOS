//
//  MistakesAlertActions.swift
//  SudokuIOS
//
//  Created by Simone Samardzhiev on 17.07.24.
//

import SwiftUI


/// View that will display the actions in the mistake alert in CellView.
struct MistakesAlertActions: View {
    /// The manager of the sudoku.
    @EnvironmentObject var sudokuManager: SudokuManager
    
    var body: some View {
        Button("Ok") {
            sudokuManager.errorAlertPresent = false
            if sudokuManager.mistakesCount == 0 {
                sudokuManager.endGame()
            }
        }
    }
}
