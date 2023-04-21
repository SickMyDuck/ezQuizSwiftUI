//
//  MenuView.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 31.03.2023.
//

import SwiftUI
import Combine

struct MenuView: View {
    @ObservedObject var viewModel: MenuViewModel

    var body: some View {
        NavigationView {
            VStack(spacing: Paddings.medium) {
                // Profile
                NavigationLink(
                    destination: ProfileView(), isActive: $viewModel.showProfileView) {
                        EmptyView()
                    }
                // Flag game
                // Country game
                // About us

                ForEach(viewModel.items, id: \.title) { item in
                    Button(action: {
                        viewModel.navigateTo(destination: item.destination)
                    }) {
                        Text(item.title)
                    }
                }
            }
            .navigationBarItems(trailing:
                                    Button {
                viewModel.showProfileView = true
            } label: {
                HStack {
                    Image(systemName: "brain.head.profile")
                        .foregroundColor(.white)
                        .padding(.trailing, Paddings.small)
                    Text("Profile")
                        .foregroundColor(.white)
                }
            })
            .padding(Paddings.medium)

        }
        .navigationBarBackButtonHidden(true)
    }
}
