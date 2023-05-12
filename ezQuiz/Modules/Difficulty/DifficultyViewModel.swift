//
//  DifficultyViewModel.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 18.04.2023.
//

import Foundation
import SwiftUI
import Combine

protocol DifficultyViewModelProtocol: ObservableObject {
    var selectedDifficulty: Difficulties { get }
    var difficultyOptions: [Difficulties] { get set }
    var showFlagsView: Bool { get set }
    var showCountryView: Bool { get set }
    var gameType: GameType { get }

    func selectDifficulty(_ difficulty: Difficulties)

    func backToMenu()
}

extension DifficultyViewModel: DifficultyViewModelProtocol {

}

class DifficultyViewModel {

    @Published var selectedDifficulty: Difficulties = .easy
    @Published var showFlagsView: Bool = false
    @Published var showCountryView: Bool = false
    @Published var gameType: GameType

    var difficultyOptions = Difficulties.allCases

    @Published private var isDifficultySelected: Bool = false
    private var router: DifficultyRouterProtocol
    private var cancellables = Set<AnyCancellable>()

    init(gameType: GameType, router: DifficultyRouterProtocol) {
        self.gameType = gameType
        self.router = router

        setupBindings() 

    }

    convenience init(gameType: GameType) {
        self.init(gameType: gameType, router: DifficultyRouter())
    }

    func selectDifficulty(_ difficulty: Difficulties) {
        isDifficultySelected = true
        selectedDifficulty = difficulty
    }

    func setupBindings() {
        $isDifficultySelected
            .filter { $0 }
            .sink { _ in
                if self.gameType == .flagGame {
                    self.showFlagsView = true
                } else {
                    self.showCountryView = true
                }
            }
            .store(in: &cancellables)
    }
}

extension DifficultyViewModel {
    // MARK: Router Methods
    func backToMenu() {
        let menuView = MenuView(viewModel: MenuViewModel())
        router.backToMenu(destination: menuView)
    }
}
