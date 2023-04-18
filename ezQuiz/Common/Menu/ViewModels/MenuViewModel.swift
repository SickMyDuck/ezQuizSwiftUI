//
//  MenuViewModel.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 31.03.2023.
//

import Foundation
import SwiftUI

class MenuViewModel: MenuViewModelProtocol {

    var router = MenuRouter()
    var user: String

    let items: [MenuItem] = [
        MenuItem(title: "Quiz", destination: AnyView(FlagsView())),
        // MenuItem(title: "Settings", destination: AnyView(SettingsView())),
        MenuItem(title: "About", destination: AnyView(AboutView()))
    ]

    init(user: String) {
        self.user = user
    }

    func navigateTo<Destination>(destination: Destination) where Destination : View {
        router.navigateTo(destination: destination)
    }
}
