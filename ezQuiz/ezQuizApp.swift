//
//  ezQuizApp.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 17.03.2023.
//

import SwiftUI

@main
struct ezQuizApp: App {
    init() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().barTintColor = .black
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }


    var body: some Scene {
        WindowGroup {
            StartView()
                .environment(\.colorScheme, .dark)
                .font(Fonts.roboto)
                .preferredColorScheme(.dark)
        }
    }
}
