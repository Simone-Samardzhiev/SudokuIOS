//
//  MistakesCounterView.swift
//  SudokuIOS
//
//  Created by Simone Samardzhiev on 14.07.24.
//

import SwiftUI


/// View that will display the count of the mistakes.
struct CountersView: View {
    /// The manager of the sudoku.
    @EnvironmentObject var sudokuManager: SudokuManager
    
    var body: some View {
        HStack {
            Text("Mistakes: \(sudokuManager.mistakesCount)")
                .font(.title2)
                .foregroundStyle(Color.primary)
            Spacer()
            
            Text("Remaining cells: \(sudokuManager.remainingCellsCount)")
                .font(.title2)
                .foregroundStyle(Color.primary)
        }
        .padding()
    }
}
