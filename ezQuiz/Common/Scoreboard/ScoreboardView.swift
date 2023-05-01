//
//  ScoreboardView.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 24.04.2023.
//

import SwiftUI
import Combine

struct ScoreboardView: View {
    @ObservedObject var viewModel: ScoreboardViewModel = ScoreboardViewModel()

    var body: some View {
        VStack {
            Text("Guess the flag:")
                .font(.headline)
            List {
                Section(header: Text("Easy")) {
                    Text("\(viewModel.bestScoreEasyFlagGame)")
                }
                Section(header: Text("Medium")) {
                    Text("\(viewModel.bestScoreMediumFlagGame)")
                }
                Section(header: Text("Hard")) {
                    Text("\(viewModel.bestScoreHardFlagGame)")
                }
            }
            .listStyle(GroupedListStyle())

                Text("Guess the country:")
                    .font(.headline)
            List {
                Section(header: Text("Easy")) {
                    Text("\(viewModel.bestScoreEasyCountryGame)")
                }
                Section(header: Text("Medium")) {
                    Text("\(viewModel.bestScoreMediumCountryGame)")
                }
                Section(header: Text("Hard")) {
                    Text("\(viewModel.bestScoreHardCountryGame)")
                }
            }
            .listStyle(GroupedListStyle())
        }
        .background(.black)
        .navigationBarTitle("Best score")
        .foregroundColor(.white)
        .onAppear {
            viewModel.onAppear()
        }
        .navigationBarItems(
            leading:
                Button {
                    viewModel.backToMenu()
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.white)
                }
        )
    }
}

struct ScoreboardView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreboardView()
    }
}
