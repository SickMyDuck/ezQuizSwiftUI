//
//  FlagsRouter.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 08.04.2023.
//

import UIKit

protocol FlagsRouterProtocol {
    func openMenu(user: String)
}

class FlagsRouter: FlagsRouterProtocol {
    func openMenu(user: String) {
        Coordinator.navigateTo(destination: MenuView(viewModel: MenuViewModel()))
   }

    func openResultsView(points: Int, difficulty: Difficulties, gameType: GameType) {
        let resultsViewModel = ResultsViewModel(points: points, difficulty: difficulty, gameType: gameType)
        let resultsView = ResultsView(viewModel: resultsViewModel)
        Coordinator.navigateTo(destination: resultsView)
    }
}
