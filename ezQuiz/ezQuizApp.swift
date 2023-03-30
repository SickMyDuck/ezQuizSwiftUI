//
//  ezQuizApp.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 17.03.2023.
//

import SwiftUI

@main
struct ezQuizApp: App {
    let viewModel = MenuViewModel()
    var body: some Scene {
        WindowGroup {
            MenuView(with: viewModel)
        }
    }
}
