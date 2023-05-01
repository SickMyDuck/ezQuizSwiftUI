//
//  ResultsView.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 01.05.2023.
//

import SwiftUI
import Combine

struct ResultsView<ViewModel: ResultsViewModel>: View {

    @ObservedObject private var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            Spacer()
            Text("Congratulations!")
                .font(Fonts.robotoBig)
            Spacer()
            Text("New Record!")
                .opacity(viewModel.showNewRecord ? 1 : 0)
                .font(Fonts.italicFont)
            
            Text(" You've earned \(viewModel.points) points!")
                .padding(Paddings.medium)


            ForEach(viewModel.items, id: \.title) { item in
                Button(action: {
                    viewModel.navigateTo(destination: item.destination, showNavBar: item.showNavBar)
                }) {
                    Text(item.title)
                        .font(Fonts.robotoBig)
                        .foregroundColor(.white)
                }
                .buttonStyle(MainButtonStyle())
                .padding(.horizontal, Paddings.large)
                .padding(.bottom, Paddings.large)
            }
            Spacer()
        }
        .onAppear(perform: viewModel.onAppear)
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(viewModel: ResultsViewModel(points: 1, difficulty: .easy, gameType: .flagGame))
    }
}
