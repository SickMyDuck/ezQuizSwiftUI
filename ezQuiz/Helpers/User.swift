//
//  User.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 19.04.2023.
//

import Foundation

struct User {
    static func saveUser(user: String) {
        UserDefaults.standard.set(user, forKey: "user")
    }

    static func getSavedUser() -> String? {
        return UserDefaults.standard.string(forKey: "user")
    }

    static func loadBestScore(key: BestScore) -> Int? {
        return UserDefaults.standard.integer(forKey: key.rawValue)
    }
}

enum BestScore: String {
    case easy = "BestScoreEasy"
    case medium = "BestScoreMedium"
    case hard = "BestScoreHard"
}
