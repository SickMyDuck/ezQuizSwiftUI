//
//  QuestionsModel.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 08.04.2023.
//

import Foundation

struct FlagQuestionItemModel: Decodable {
    let questions: [FlagQuestion]
}

struct FlagQuestion: Decodable {
    let flagImage: String
    let answers: [String]
    let correctAnswer: String
    let difficulty: Difficulties

    enum CodingKeys: String, CodingKey {
        case flagImage
        case answers
        case correctAnswer = "correct_answer"
        case difficulty
    }
}

extension Difficulties: Decodable {

}
