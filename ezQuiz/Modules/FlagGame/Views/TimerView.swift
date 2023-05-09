//
//  TimerView.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 30.04.2023.
//

import SwiftUI

struct TimerView<ViewModel: GameLogicProtocol>: View {
    @ObservedObject private var viewModel: ViewModel
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let radius: CGFloat = 30

    init(with viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 10)
                .opacity(0.3)
                .foregroundColor(.gray)

            Circle()
                .trim(from: 0, to: CGFloat(1 - (viewModel.timeRemaining / 30)))
                .stroke(style: StrokeStyle(lineWidth: 7, lineCap: .round, lineJoin: .round))
                .foregroundColor(.green)
                .rotationEffect(.degrees(-90))

            Text("\(Int(viewModel.timeRemaining))")
                .font(.largeTitle)
                .foregroundColor(.green)
                .onReceive(timer) { _ in
                    if viewModel.timeRemaining > 0 {
                        viewModel.timeRemaining -= 1
                    } else {
                        viewModel.timeOut.toggle()
                    }
                }
        }
        .frame(width: radius * 2, height: radius * 2)
    }
}

