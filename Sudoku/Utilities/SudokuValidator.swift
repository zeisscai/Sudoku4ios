//
//  SudokuValidator.swift
//  Sudoku
//
//  Created by Zwiss Cai on 2025/3/4.
//
// Utilities/SudokuValidator.swift

import Foundation

func isValidMove(grid: [[Int]], row: Int, col: Int, num: Int) -> Bool {
    // 检查行
    for d in 0..<9 {
        if grid[row][d] == num && d != col {
            return false
        }
    }
    
    // 检查列
    for d in 0..<9 {
        if grid[d][col] == num && d != row {
            return false
        }
    }
    
    // 检查 3x3 子网格
    let startRow = row - row % 3
    let startCol = col - col % 3
    for i in 0..<3 {
        for j in 0..<3 {
            if grid[i + startRow][j + startCol] == num && (i + startRow != row || j + startCol != col) {
                return false
            }
        }
    }
    
    return true
}
