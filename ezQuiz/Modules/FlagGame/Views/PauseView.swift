//
//  PauseView.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 20.04.2023.
//

import Foundation
import SwiftUI

struct PauseView<ViewModel: GameLogicProtocol>: View {

    @ObservedObject var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        Color.black.opacity(0.5)
            .ignoresSafeArea()
            .onTapGesture {
                // Скрыть меню при нажатии за его пределами
                viewModel.isMenuVisible.toggle()
            }
        VStack {
            Button("Continue") {
                viewModel.isMenuVisible.toggle()
            }
            .font(Fonts.roboto)
            .padding(.bottom)
            Button("Back to Menu") {
                viewModel.needToOpenMenu.toggle()
            }
            .font(Fonts.roboto)
        }
        .foregroundColor(.white)
        .padding()
        .background(Color.gray)
        .cornerRadius(10)
    }
}
