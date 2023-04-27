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

    private let router = MenuRouter()

    let items: [MenuItem] = [
        MenuItem(title: "Guess the flag", destination: AnyView(DifficultyView(with: DifficultyViewModel())), showNavBar: false),
        MenuItem(title: "Guess the country", destination: AnyView(DifficultyView(with: DifficultyViewModel()))
                 , showNavBar: false),
        MenuItem(title: "Scoreboard", destination: AnyView(ScoreboardView()), showNavBar: true)
    ]

    func navigateTo<Destination>(destination: Destination, showNavBar: Bool) where Destination : View {
        router.navigateTo(destination: destination, showNavBar: showNavBar)
    }
}
