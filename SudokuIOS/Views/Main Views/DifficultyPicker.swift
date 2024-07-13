//
//  DifficultyPicker.swift
//  SudokuIOS
//
//  Created by Simone Samardzhiev on 13.07.24.
//

import SwiftUI

/// Struct used to create a picker for the difficulty.
struct DifficultyPicker: View {
    /// The manager of the sudoku.
    @EnvironmentObject var sudokuManager: SudokuManager
    
    var body: some View {
        Picker("Pick difficulty", selection: $sudokuManager.difficulty) {
            Text(SudokuDifficulty.easy.rawValue)
                .tag(SudokuDifficulty.easy)
            Text(SudokuDifficulty.normal.rawValue)
                .tag(SudokuDifficulty.normal)
            Text(SudokuDifficulty.hard.rawValue)
                .tag(SudokuDifficulty.hard)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
        .shadow(radius: 10)
    }
}
