//
//  MenuView.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 31.03.2023.
//

import SwiftUI
import Combine

struct MenuView<ViewModel: MenuViewModelProtocol> : View {

    @ObservedObject var viewModel: ViewModel

    init(with viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            List(viewModel.difficultyOptions, id: \.self) { difficulty in
                Button(action: {
                    viewModel.selectDifficulty(difficulty)
                }) {
                    Text(difficulty.rawValue)
                }
                .navigationTitle("Select Difficulty")
            }
        }
    }
}
