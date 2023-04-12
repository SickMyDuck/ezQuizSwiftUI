//
//  FlagView.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 08.04.2023.
//

import SwiftUI
import Combine

struct FlagsView: View {

    @ObservedObject var viewModel = FlagsViewModel()

    var body: some View {
        Text("Hello, Wfrld!")
        Button("load") {
            viewModel.increaseQuestionsCounter()
        }
        .onAppear(perform: viewModel.onAppear)
    }
}

struct FlagsView_Previews: PreviewProvider {
    static var previews: some View {
        FlagsView()
    }
}
