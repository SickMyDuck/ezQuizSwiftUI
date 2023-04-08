//
//  MenuScreenTests.swift
//  ezQuizTests
//
//  Created by Ruslan Sadritdinov on 31.03.2023.
//

import XCTest
import Foundation
import Combine
@testable import ezQuiz

final class MenuScreenTests: XCTestCase {

    func test_ShowThreeDifficultyOption() {

        // GIVEN
        let viewModel = MenuViewModel()
        let view = MenuView(with: viewModel)

        // WHEN
        let expectedDifficulties: [Difficulties] = [.easy, .medium, .hard]
        let actualDifficulties = view.viewModel.difficultyOptions

        // THEN
        XCTAssertEqual(expectedDifficulties, actualDifficulties)
    }

    func test_SelectDifficulty() {

        // GIVEN
        let viewModel = MenuViewModel()
        let view = MenuView(with: viewModel)

        // WHEN
        let selectedDifficulty = Difficulties.medium
        view.viewModel.selectDifficulty(selectedDifficulty)

        // THEN
        XCTAssertEqual(view.viewModel.selectedDifficulty, selectedDifficulty)
    }
}
