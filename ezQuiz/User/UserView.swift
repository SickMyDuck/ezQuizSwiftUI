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

    @State private var showNextView: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your name", text: $viewModel.user)
                    .padding()

                let menuViewModel = MenuViewModel(user: viewModel.user)
                NavigationLink(destination: MenuView(with: menuViewModel), isActive: $showNextView) {
                    EmptyView()
                }

                Button {
                    viewModel.saveUser()
                    showNextView = true
                } label: {
                    Text("Start Quiz")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .disabled(viewModel.user.isEmpty)
            }
            .padding()
            .navigationTitle("Welcome!")
        }
    }
}
