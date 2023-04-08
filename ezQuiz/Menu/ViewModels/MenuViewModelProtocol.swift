//
//  MenuViewModelProtocol.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 31.03.2023.
//

import Foundation

protocol MenuViewModelProtocol: ObservableObject {
    var selectedDifficulty: Difficulties? { get }
    var difficultyOptions: [Difficulties] { get }

    func selectDifficulty(_ difficulty: Difficulties)
}

extension MenuViewModel: MenuViewModelProtocol {

}
