//
//  ProfileView.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 19.04.2023.
//

import SwiftUI
import Combine

struct ProfileView: View {
    @ObservedObject var viewModel = ProfileViewModel()

    var body: some View {
        VStack {
            TextField("Enter your name", text: $viewModel.user)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            HStack {
                Text("Best Scores:")
                    .font(.headline)
                Spacer()
            }
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
            .navigationBarTitle("Profile")
            .navigationBarItems(trailing: Button(action: {
                viewModel.saveUserName()
                viewModel.openMenu()
            }) {
                Text("Save")
            })
            .onAppear {
                viewModel.loadUser()
                viewModel.loadBestScores()
            }
        }
    }
}
