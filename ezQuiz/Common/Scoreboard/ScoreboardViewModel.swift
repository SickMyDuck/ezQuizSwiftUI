//
//  ScoreboardViewModel.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 24.04.2023.
//

import Foundation

class ScoreboardViewModel: ObservableObject {

    let router = ScoreboardRouter()

    @Published var bestScoreEasy: Int = 0
    @Published var bestScoreMedium: Int = 0
    @Published var bestScoreHard: Int = 0

    func loadBestScores() {
        bestScoreEasy = User.loadBestScore(key: .easy) ?? 0
        bestScoreMedium = User.loadBestScore(key: .medium) ?? 0
        bestScoreHard = User.loadBestScore(key: .hard) ?? 0
    }
}

extension ScoreboardViewModel {
    // MARK: Router Methods
    func backToMenu() {
        let menuView = MenuView(viewModel: MenuViewModel())
        router.backToMenu(destination: menuView)
    }
}
