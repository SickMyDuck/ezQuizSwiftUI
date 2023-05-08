//
//  DifficultyViewModel.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 18.04.2023.
//

import Foundation
import Combine

protocol DifficultyViewModelProtocol: ObservableObject {
    var selectedDifficulty: Difficulties { get }
    var difficultyOptions: [Difficulties] { get set }
    var showFlagsView: Bool { get set }

    func selectDifficulty(_ difficulty: Difficulties)

    func backToMenu()
}

extension DifficultyViewModel: DifficultyViewModelProtocol {

}

class DifficultyViewModel {

    @Published var selectedDifficulty: Difficulties = .easy
    @Published var showFlagsView: Bool = false
    var difficultyOptions = Difficulties.allCases

    private var router = DifficultyRouter()

    func selectDifficulty(_ difficulty: Difficulties) {
        showFlagsView = true
        selectedDifficulty = difficulty
    }
}

extension DifficultyViewModel {
    // MARK: Router Methods
    func backToMenu() {
        let menuView = MenuView(viewModel: MenuViewModel())
        router.backToMenu(destination: menuView)
    }
}
