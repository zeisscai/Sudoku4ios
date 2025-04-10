//
//  SudokuGrid.swift
//  Sudoku
//
//  Created by Zwiss Cai on 2025/3/4.
//


// Views/SudokuGrid.swift
import SwiftUI
struct SudokuGrid: View {
    @Binding var grid: [[Int]]           // 当前网格数据
    @Binding var initialGrid: [[Int]]   // 初始网格数据
    @Binding var selectedCell: (row: Int, col: Int)?  // 当前选中的格子
    @Environment(\.colorScheme) var colorScheme  // 检测深色/浅色模式

    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<9, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(0..<9, id: \.self) { col in
                        let num = grid[row][col]              // 当前格子的数字
                        let isInitial = initialGrid[row][col] != 0  // 是否为初始格子
                        let isSelected = selectedCell?.row == row && selectedCell?.col == col  // 是否选中
                        let backgroundColor = getBackgroundColor(isSelected: isSelected)  // 背景颜色

                        ZStack {
                            backgroundColor  // 格子背景
                            Text(num == 0 ? "" : "\(num)")  // 显示数字
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(isInitial ? .red : .blue)  // 初始数字为红色，其他为蓝色
                        }
                        .frame(width: 40, height: 40)  // 格子大小固定为 40x40
                        .border(Color.gray, width: 0.5)  // 细边框
                        .overlay(
                            GeometryReader { geometry in
                                Path { path in
                                    let frame = geometry.frame(in: .local)
                                    // 绘制 3x3 子网格的粗边框
                                    if row % 3 == 0 {
                                        path.move(to: CGPoint(x: 0, y: 0))
                                        path.addLine(to: CGPoint(x: frame.width, y: 0))
                                    }
                                    if col % 3 == 0 {
                                        path.move(to: CGPoint(x: 0, y: 0))
                                        path.addLine(to: CGPoint(x: 0, y: frame.height))
                                    }
                                    if (row + 1) % 3 == 0 {
                                        path.move(to: CGPoint(x: 0, y: frame.height))
                                        path.addLine(to: CGPoint(x: frame.width, y: frame.height))
                                    }
                                    if (col + 1) % 3 == 0 {
                                        path.move(to: CGPoint(x: frame.width, y: 0))
                                        path.addLine(to: CGPoint(x: frame.width, y: frame.height))
                                    }
                                }
                                .stroke(colorScheme == .dark ? Color.white : Color.black, lineWidth: 2)
                            }
                        )
                        .contentShape(Rectangle())  // 关键修改：确保点击区域与格子大小一致
                        .onTapGesture {
                            if !isInitial {  // 只有非初始格子可以被选中
                                selectedCell = (row, col)
                            }
                        }
                    }
                }
            }
        }
        .border(colorScheme == .dark ? Color.white : Color.black, width: 2)  // 整个网格的边框
    }

    // 计算背景颜色的辅助函数
    func getBackgroundColor(isSelected: Bool) -> Color {
        if isSelected {
            return colorScheme == .dark ? Color.gray.opacity(0.3) : Color.blue.opacity(0.3)
        }
        return Color.clear
    }
}
