//
//  StartButton.swift
//  SudokuIOS
//
//  Created by Simone Samardzhiev on 13.07.24.
//

import SwiftUI


/// Button used to start the game.
struct StartButton: View {
    /// The manager of the sudoku.
    @EnvironmentObject var sudokuManager: SudokuManager
    
    var body: some View {
        Button {
            sudokuManager.startGame()
        } label: {
            Text("Start Game")
                .foregroundStyle(Color.primary)
                .font(.largeTitle)
                .padding()
                .background(alignment: .center) {
                    RoundedRectangle(cornerRadius: 25.0)
                }
        }

    }
}
