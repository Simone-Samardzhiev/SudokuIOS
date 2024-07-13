//
//  MainView.swift
//  SudokuIOS
//
//  Created by Simone Samardzhiev on 12.07.24.
//

import SwiftUI

/// The main view of the sudoku.
struct MainView: View {
    /// The manager of the sudoku.
    @StateObject var sudokuManager = SudokuManager()
    
    var body: some View {
        GeometryReader { geo in
            NavigationStack {
                VStack {
                    DifficultyPicker()
                    
                    StartButton(
                        width: geo.size.width / 3,
                        height: geo.size.height / 10
                    )
                }
                .navigationTitle("Sudoku")
                .environmentObject(sudokuManager)
            }
        }
    }
}

#Preview {
    MainView()
}
