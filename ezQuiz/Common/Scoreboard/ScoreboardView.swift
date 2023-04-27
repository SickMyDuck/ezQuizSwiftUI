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
        ScrollView {
            HStack {
                Text("Guess the flag:")
                    // .font(.headline)
                Spacer()
            }
            .background(.black)
           List {
                Section(header: Text("Easy")) {
                    Text("\(viewModel.bestScoreEasy)")
                }
                Section(header: Text("Medium")) {
                    Text("\(viewModel.bestScoreMedium)")
                }
                Section(header: Text("Hard")) {
                    Text("\(viewModel.bestScoreHard)")
                }
            }
            .listStyle(GroupedListStyle())

            HStack {
                Text("Guess the country:")
                    .font(.headline)
                Spacer()
            }
            .background(.black)
            List {
                Section(header: Text("Easy")) {
                    Text("\(viewModel.bestScoreEasy)")
                }
                Section(header: Text("Medium")) {
                    Text("\(viewModel.bestScoreMedium)")
                }
                Section(header: Text("Hard")) {
                    Text("\(viewModel.bestScoreHard)")
                }
            }
            .listStyle(GroupedListStyle())
        }
        .background(.black)
        .navigationBarTitle("Best score")
        .onAppear {
            viewModel.loadBestScores()
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
