//
//  DifficultyView.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 18.04.2023.
//

import SwiftUI
import Combine

struct DifficultyView<ViewModel: DifficultyViewModelProtocol> : View {

    @ObservedObject var viewModel: ViewModel

    init(with viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: FlagsView(viewModel: FlagsViewModel(difficulty: viewModel.selectedDifficulty)), isActive: $viewModel.showFlagsView) {
                    EmptyView()
                }
                NavigationLink(destination: CountryView(viewModel: CountryViewModel(difficulty: viewModel.selectedDifficulty)), isActive: $viewModel.showCountryView) {
                    EmptyView()
                }
                ForEach(viewModel.difficultyOptions, id: \.self) { difficulty in
                    Button(action: {
                        viewModel.selectDifficulty(difficulty)
                    }) {
                        Text(difficulty.rawValue)
                            .font(Fonts.roboto)
                            .foregroundColor(.white)
                    }
                    .buttonStyle(MainButtonStyle())
                    .padding(.horizontal, Paddings.large)
                    .padding(.bottom, Paddings.medium)
                }
            }
            .transition(.move(edge: .leading))
            .animation(.easeInOut)
            .navigationBarTitle("Select difficulty", displayMode: .inline)
            .navigationBarItems(
                leading:
                Button {
                    viewModel.backToMenu()
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.white)
                }
            )
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct DifficultyView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = DifficultyViewModel(gameType: .flagGame)
        DifficultyView(with: viewModel)
    }
}
