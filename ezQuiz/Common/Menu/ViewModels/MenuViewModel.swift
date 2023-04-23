//
//  MenuViewModel.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 31.03.2023.
//

import Foundation
import SwiftUI

class MenuViewModel: MenuViewModelProtocol {

    @Published var showProfileView: Bool = false
    @Published var showAboutView: Bool = false
    @Published var showFlagsView: Bool = false

    let items: [MenuItem] = [
        MenuItem(title: "Guess the flag", destination: AnyView(DifficultyView(with: DifficultyViewModel()))),
        MenuItem(title: "Guess the country", destination: AnyView(DifficultyView(with: DifficultyViewModel()))),
        MenuItem(title: "Scoreboard", destination: AnyView(DifficultyView(with: DifficultyViewModel())))
    ]

    private let router = MenuRouter()

    func navigateTo<Destination>(destination: Destination) where Destination : View {
        router.navigateTo(destination: destination)
    }
}
