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
        ZStack{
            NavigationView {
                VStack {
                    List(viewModel.difficultyOptions, id: \.self) { difficulty in
                        NavigationLink(destination: FlagsView()) {
                            Text(difficulty.rawValue)
                        }
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct DifficultyView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = DifficultyViewModel()
        DifficultyView(with: viewModel)
    }
}
