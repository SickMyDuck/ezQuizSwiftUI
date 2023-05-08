//
//  ScoreboardViewModel.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 24.04.2023.
//

import Foundation

class ScoreboardViewModel: ObservableObject {

    @Published var bestScoreEasyFlagGame: Int = 0
    @Published var bestScoreMediumFlagGame: Int = 0
    @Published var bestScoreHardFlagGame: Int = 0
    @Published var bestScoreEasyCountryGame: Int = 0
    @Published var bestScoreMediumCountryGame: Int = 0
    @Published var bestScoreHardCountryGame: Int = 0

    private let coreDataHelper = CoreDataHelper()
    private let router = ScoreboardRouter()
    
    func onAppear() {
        loadBestScores()
    }

    func loadBestScores() {
        bestScoreEasyFlagGame = getScore(difficulty: .easy, gameType: .flagGame)
        bestScoreMediumFlagGame = getScore(difficulty: .medium, gameType: .flagGame)
        bestScoreHardFlagGame = getScore(difficulty: .hard, gameType: .flagGame)
        bestScoreEasyCountryGame = getScore(difficulty: .easy, gameType: .countryGame)
        bestScoreMediumCountryGame = getScore(difficulty: .medium, gameType: .countryGame)
        bestScoreHardCountryGame = getScore(difficulty: .hard, gameType: .countryGame)
    }

    func getScore(difficulty: Difficulties, gameType: GameType) -> Int {
        var score = 0
        let results = coreDataHelper.getRecords(for: difficulty, and: gameType)
        if !results.isEmpty {
            score = Int(results[0].result)
        }
        return score
    }
}

extension ScoreboardViewModel {
    // MARK: Router Methods
    func backToMenu() {
        let menuView = MenuView(viewModel: MenuViewModel())
        router.backToMenu(destination: menuView)
    }
}
