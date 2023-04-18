//
//  WelcomeView.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 18.04.2023.
//

import Foundation
import SwiftUI
import Combine

struct WelcomeView: View {
    @ObservedObject var viewModel: WelcomeViewModel

    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome back, \(viewModel.user)!")
                    .font(.title)
                    .padding()

                NavigationLink(
                    destination: MenuView(viewModel: MenuViewModel(user: viewModel.user)),
                    label: {
                        Text("Start Quiz")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    })
                Button {
                    viewModel.deleteUser()
                } label: {
                    Text("delete")
                }

            }
            .padding()
            .navigationTitle("Welcome!")
        }
    }
}
