//
//  UserView.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 18.04.2023.
//

import SwiftUI
import Combine

struct UserView: View {
    @ObservedObject var viewModel: UserViewModel

    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your name", text: $viewModel.user)
                    .padding()
                NavigationLink(destination: MenuView(viewModel: MenuViewModel(user: viewModel.user)), isActive: $viewModel.showNextView) {
                    EmptyView()
                }

                Button {
                    viewModel.saveUser()
                    viewModel.showNextView = true
                } label: {
                    Text("Start Quiz")
                        .foregroundColor(viewModel.user.isEmpty ? Color.black : Color.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(viewModel.user.isEmpty ? Color.gray : Color.blue)
                        .cornerRadius(10)
                }
                .disabled(viewModel.user.isEmpty)
            }
            .padding()
            .navigationTitle("Welcome!")
        }
    }
}
