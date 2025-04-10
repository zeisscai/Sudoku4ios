//
//  SudokuGennerator.swift
//  Sudoku
//
//  Created by Zwiss Cai on 2025/3/4.
//
// Models/SudokuGenerator.swift

import Foundation
class SudokuGenerator {
    var grid = [[Int]](repeating: [Int](repeating: 0, count: 9), count: 9)
    
    func isSafe(row: Int, col: Int, num: Int) -> Bool {
        // 检查行、列和3x3子网格的合法性（保持不变）
        for x in 0..<9 {
            if grid[row][x] == num || grid[x][col] == num {
                return false
            }
        }
        let startRow = row - row % 3
        let startCol = col - col % 3
        for i in 0..<3 {
            for j in 0..<3 {
                if grid[i + startRow][j + startCol] == num {
                    return false
                }
            }
        }
        return true
    }
    
    func solveSudoku() -> Bool {
        for row in 0..<9 {
            for col in 0..<9 {
                if grid[row][col] == 0 {
                    let numbers = (1...9).shuffled()
                    for num in numbers {
                        if isSafe(row: row, col: col, num: num) {
                            grid[row][col] = num
                            if solveSudoku() {
                                return true
                            }
                            grid[row][col] = 0
                        }
                    }
                    return false
                }
            }
        }
        return true
    }
    
    func generatePuzzle(difficulty: String) {
        solveSudoku()
        
        var toRemove: Int
        switch difficulty {
        case "Easy":
            toRemove = Int.random(in: 30...40)
        case "Medium":
            toRemove = Int.random(in: 45...50)
        case "Hard":
            toRemove = Int.random(in: 55...60)
        default:
            toRemove = 0
        }
        
        var removed = 0
        var positions = [(Int, Int)]()
        for row in 0..<9 {
            for col in 0..<9 {
                positions.append((row, col))
            }
        }
        positions.shuffle()
        
        for pos in positions {
            if removed >= toRemove {
                break
            }
            let (row, col) = pos
            if grid[row][col] != 0 {
                grid[row][col] = 0
                removed += 1
            }
        }
    }
}
