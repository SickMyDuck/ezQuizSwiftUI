//
//  ProfileViewModel.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 19.04.2023.
//

import SwiftUI
import Combine

class ProfileViewModel: ObservableObject {
    @Published var user: String = ""
    @Published var bestScoreEasy: Int = 0
    @Published var bestScoreMedium: Int = 0
    @Published var bestScoreHard: Int = 0

    private let router = profileRouter()
    private let userDefaults = UserDefaults.standard

    private var cancellables = Set<AnyCancellable>()

    func loadUser() {
        user = User.getSavedUser() ?? ""
    }

    func saveUserName() {
        User.saveUser(user: user)
    }

    func loadBestScores() {
        bestScoreEasy = User.loadBestScore(key: .easy) ?? 0
        bestScoreMedium = User.loadBestScore(key: .medium) ?? 0
        bestScoreHard = User.loadBestScore(key: .hard) ?? 0
    }

    func openMenu() {
        router.openMenu(user: user)
    }
}
