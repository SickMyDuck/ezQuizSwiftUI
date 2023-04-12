//
//  FlagScreenTests.swift
//  ezQuizTests
//
//  Created by Ruslan Sadritdinov on 05.04.2023.
//

import XCTest
import Foundation
import Combine
@testable import ezQuiz

final class FlagScreenTests: XCTestCase {

    func test_checkCorrectAnswer() {
        // GIVEN
        let viewModel = FlagsViewModel()
        let view = FlagsView()

        // WHEN
        let expectedDifficulties: [Difficulties] = [.easy, .medium, .hard]
        let actualDifficulties = view.$viewModel.difficultyOptions

        // THEN
        XCTAssertEqual(expectedDifficulties, actualDifficulties)
    }

    func test_startNewRound() {

    }

    func test_loadQuestions() {
        let decoder = JSONDecoder()
        let data = String.mockQuestionsData.data(using: .utf8)!
        XCTAssertNoThrow(try! decoder.decode(QuestionItemModel.self, from: data))
    }

}


private extension String {
    static let mockQuestionsData = """
        "url": "https://sickmyduck.ru/api/get_image/russia/"
    """
}
