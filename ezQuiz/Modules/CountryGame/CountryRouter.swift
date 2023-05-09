//
//  CountryRouter.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 09.05.2023.
//

import UIKit

protocol CountryRouterProtocol {
    func openMenu(user: String)
    func openResultsView(points: Int, difficulty: Difficulties, gameType: GameType)
}

class CountryRouter: CountryRouterProtocol {
    func openMenu(user: String) {
        Coordinator.navigateTo(destination: MenuView(viewModel: MenuViewModel()))
   }

    func openResultsView(points: Int, difficulty: Difficulties, gameType: GameType) {
        let resultsViewModel = ResultsViewModel(points: points, difficulty: difficulty, gameType: gameType)
        let resultsView = ResultsView(viewModel: resultsViewModel)
        Coordinator.navigateTo(destination: resultsView)
    }
}
