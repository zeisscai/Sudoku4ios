//
//  RestartButton.swift
//  Sudoku
//
//  Created by Zwiss Cai on 2025/3/4.
//

// Views/RestartButton.swift

import SwiftUI

struct RestartButton: View {
    @Binding var grid: [[Int]]
    @Binding var initialGrid: [[Int]]
    @Binding var selectedCell: (row: Int, col: Int)?
    @Binding var timeElapsed: Int
    var difficulty: String
    
    var body: some View {
        Button(action: {
            let generator = SudokuGenerator()
            generator.generatePuzzle(difficulty: difficulty)
            grid = generator.grid
            initialGrid = grid.map { $0.map { $0 } }
            selectedCell = nil
            timeElapsed = 0 // 重置计时器
        }) {
            Image(systemName: "arrow.counterclockwise")
                .font(.system(size: 24))
        }
    }
}
