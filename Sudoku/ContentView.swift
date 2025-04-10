//
//  ContentView.swift
//  Sudoku
//
//  Created by Zwiss Cai on 2025/3/4.
//
// ContentView.swift
import SwiftUI
struct ContentView: View {
    @State private var grid: [[Int]] = Array(repeating: Array(repeating: 0, count: 9), count: 9)
    @State private var initialGrid: [[Int]] = Array(repeating: Array(repeating: 0, count: 9), count: 9)
    @State private var selectedCell: (row: Int, col: Int)? = nil
    @State private var difficulty = "Easy"
    @State private var timeElapsed = 0
    @State private var isSolved = false
    @State private var showCelebration = false

    var body: some View {
        VStack {
            if showCelebration {
                Text("🎉太棒了")
                    .font(.largeTitle)
                Text("用时: \(timeString(time: timeElapsed))")
                    .font(.title)
            } else {
                
                Text("数独")
                    .font(.largeTitle)
                
                HStack {
                    TimerView(timeElapsed: $timeElapsed, isSolved: $isSolved)
                    Spacer()
                    RestartButton(grid: $grid, initialGrid: $initialGrid, selectedCell: $selectedCell, timeElapsed: $timeElapsed, difficulty: difficulty)
                }
                .padding()

                Picker("Difficulty", selection: $difficulty) {
                    Text("Easy").tag("Easy")
                    Text("Medium").tag("Medium")
                    Text("Hard").tag("Hard")
                }
                .pickerStyle(SegmentedPickerStyle())
                .onChange(of: difficulty) { _ in
                    resetGame()
                }

                SudokuGrid(grid: $grid, initialGrid: $initialGrid, selectedCell: $selectedCell)
                    .onChange(of: grid) { _ in
                        if isSudokuSolved(grid: grid) {
                            isSolved = true
                            showCelebration = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                resetGame()
                            }
                        }
                    }

                NumberSelector(grid: $grid, selectedCell: $selectedCell)


            }
        }
        .padding()
        .onAppear {
            resetGame()
        }
    }

    func resetGame() {
        let generator = SudokuGenerator()
        generator.generatePuzzle(difficulty: difficulty)
        grid = generator.grid
        initialGrid = grid.map { $0.map { $0 } }
        selectedCell = nil
        timeElapsed = 0
        isSolved = false
        showCelebration = false
    }

    func timeString(time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

func isSudokuSolved(grid: [[Int]]) -> Bool {
    // 检查行
    for row in 0..<9 {
        var rowSet = Set<Int>()
        for col in 0..<9 {
            let num = grid[row][col]
            if num == 0 || rowSet.contains(num) { return false }
            rowSet.insert(num)
        }
    }
    // 检查列
    for col in 0..<9 {
        var colSet = Set<Int>()
        for row in 0..<9 {
            let num = grid[row][col]
            if num == 0 || colSet.contains(num) { return false }
            colSet.insert(num)
        }
    }
    // 检查3×3子网格
    for boxRow in 0..<3 {
        for boxCol in 0..<3 {
            var boxSet = Set<Int>()
            for i in 0..<3 {
                for j in 0..<3 {
                    let num = grid[boxRow*3 + i][boxCol*3 + j]
                    if num == 0 || boxSet.contains(num) { return false }
                    boxSet.insert(num)
                }
            }
        }
    }
    return true
}
