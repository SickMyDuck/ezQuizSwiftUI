//
//  DifficultyViewModel.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 18.04.2023.
//

import Foundation
import Combine

protocol DifficultyViewModelProtocol: ObservableObject {
    var selectedDifficulty: Difficulties? { get }
    var difficultyOptions: [Difficulties] { get }

    func selectDifficulty(_ difficulty: Difficulties)
}

extension DifficultyViewModel: DifficultyViewModelProtocol {

}

class DifficultyViewModel {

    @Published var selectedDifficulty: Difficulties?
    let difficultyOptions = Difficulties.allCases


    func selectDifficulty(_ difficulty: Difficulties) {
        selectedDifficulty = difficulty
    }
}
