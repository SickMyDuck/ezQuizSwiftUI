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
                VStack {
                    // Text
                    Text("Discover the world in one symbol")
                        .font(Fonts.italicFont)
                        .padding(Paddings.large)
                        .frame(alignment: .center)
                        .multilineTextAlignment(.center)
                    Spacer()

                    ForEach(viewModel.items, id: \.title) { item in
                        Button(action: {
                            viewModel.navigateTo(destination: item.destination)
                        }) {
                            Text(item.title)
                                .font(Fonts.robotoBig)
                                .foregroundColor(.white)
                        }
                        .buttonStyle(MenuButtonStyle())
                        .padding(.horizontal, Paddings.large)
                        .padding(.bottom, Paddings.large)
                    }
                    // About
                    Spacer()
                    HStack {
                        Button(action: {
                                  viewModel.showAboutView.toggle()
                              }) {
                                  Text("SeeqMyDuck © 2023")
                                      .foregroundColor(.white)
                              }
                              .sheet(isPresented: $viewModel.showAboutView) {
                                  AboutView()
                              }
                              .padding(Paddings.small)
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
                    Text("Profile")
                        .foregroundColor(.white)
                }
                .padding(.horizontal, Paddings.semiSmall)
            }
                .buttonStyle(ProfileButtonStyle())
            )
            .padding(Paddings.medium)

        }
        .navigationBarBackButtonHidden(true)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(viewModel: MenuViewModel())
    }
}
