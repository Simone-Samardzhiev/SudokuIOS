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
    /// The width of the start button.
    let width: CGFloat
    /// The height of the start button.
    let height: CGFloat
    
    /// Initialiser of the start button.
    /// - Parameters:
    ///   - width: The width of the start button.
    ///   - height: The height of the start button.
    init(width: CGFloat, height: CGFloat) {
        self.width = width
        self.height = height
    }
    
    var body: some View {
        Button {
            sudokuManager.startGame()
        } label: {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: width, height: height)
                .overlay(alignment: .center) {
                    Text("Start game")
                        .foregroundStyle(Color.primary)
                }
        }

    }
}
