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
        ZStack{
            NavigationView {
                VStack {
                    List(viewModel.difficultyOptions, id: \.self) { difficulty in
                        NavigationLink(destination: FlagsView()) {
                            Text(difficulty.rawValue)
                        }
                    }
                    .navigationTitle("Choose difficulty")
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = MenuViewModel()
        MenuView(with: viewModel)
    }
}
