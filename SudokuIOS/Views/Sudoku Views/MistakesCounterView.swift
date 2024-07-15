//
//  MistakesCounterView.swift
//  SudokuIOS
//
//  Created by Simone Samardzhiev on 14.07.24.
//

import SwiftUI


/// View that will display the count of the mistakes.
struct MistakesCounterView: View {
    /// The manager of the sudoku.
    @EnvironmentObject var sudokuManager: SudokuManager
    
    var body: some View {
        HStack {
            Text("Mistakes: \(sudokuManager.mistakesCount)")
                .font(.title)
                .foregroundStyle(Color.primary)
            Spacer()
        }
        .padding()
    }
}
