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
                    destination: MenuView(viewModel: MenuViewModel()),
                    isActive: $viewModel.showMenuView) {
                        EmptyView()
                    }
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    viewModel.showMenuView = true
                }
            }
            .padding()
            .navigationTitle("Welcome!")
        }
    }
}
