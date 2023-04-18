//
//  MenuViewModel.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 31.03.2023.
//

import Foundation
import Combine

class MenuViewModel {

    @Published var selectedDifficulty: Difficulties?
    let difficultyOptions = Difficulties.allCases
    var user = ""

    init(user: String)  {
        self.user = user
    }

    func selectDifficulty(_ difficulty: Difficulties) {
        selectedDifficulty = difficulty
    }
}
