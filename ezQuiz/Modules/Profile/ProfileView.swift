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
                .navigationBarTitle("Profile")
                .navigationBarItems(trailing: Button(action: {
                    viewModel.saveUserName()
                    viewModel.openMenu()
                }) {
                    Text("Save")
                })
                .onAppear {
                    viewModel.loadUser()
                }
        }
    }
}
