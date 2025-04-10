//
//  TimerView.swift
//  Sudoku
//
//  Created by Zwiss Cai on 2025/3/4.
//
// Views/TimerView.swift

import SwiftUI

struct TimerView: View {
    @Binding var timeElapsed: Int
    @Binding var isSolved: Bool
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        Text(timeString(time: timeElapsed))
            .onReceive(timer) { _ in
                if !isSolved {
                    timeElapsed += 1
                }
            }
    }

    func timeString(time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
