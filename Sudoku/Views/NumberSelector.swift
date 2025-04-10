//
//  NumberSelector.swift
//  Sudoku
//
//  Created by Zwiss Cai on 2025/3/4.
//

// Views/NumberSelector.swift
import SwiftUI

struct NumberSelector: View {
    @Binding var grid: [[Int]]
    @Binding var selectedCell: (row: Int, col: Int)?
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach(0..<3) { row in
                HStack(spacing: 10) {
                    ForEach(0..<3) { col in
                        let num = row * 3 + col + 1
                        Button(action: {
                            if let cell = selectedCell {
                                grid[cell.row][cell.col] = num
                            }
                        }) {
                            Text("\(num)")
                                .font(.system(size: 24))
                                .frame(width: 40, height: 40)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(5)
                        }
                    }
                }
            }
        }
    }
}
