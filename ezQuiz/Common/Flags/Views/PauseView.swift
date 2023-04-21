//
//  PauseView.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 20.04.2023.
//

import Foundation
import SwiftUI

struct PauseView: View {
    @ObservedObject var viewModel: FlagsViewModel

    var body: some View {
        Color.black.opacity(0.5)
            .ignoresSafeArea()
            .onTapGesture {
                // Скрыть меню при нажатии за его пределами
                viewModel.isMenuVisible.toggle()
            }
        VStack {
            Button("Продолжить") {
                viewModel.isMenuVisible.toggle()
            }
            .font(Fonts.roboto)
            .padding(.bottom)
            Button("Back to Menu") {
                viewModel.openMenu()
            }
            .font(Fonts.roboto)
        }
        .foregroundColor(.white)
        .padding()
        .background(Color.gray)
        .cornerRadius(10)
    }
}
