//
//  CountryItemModel.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 09.05.2023.
//

import Foundation

struct CountryQuestionItemModel: Decodable {
    let questions: [CountryQuestion]
}

struct CountryQuestion: Decodable {
    let country: String
    let answers: [String]
    let correctAnswer: String
    let difficulty: Difficulties

    enum CodingKeys: String, CodingKey {
        case country
        case answers
        case correctAnswer = "correct_answer"
        case difficulty
    }
}
