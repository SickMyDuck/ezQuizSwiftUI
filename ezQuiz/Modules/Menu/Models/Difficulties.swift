//
//  Difficulties.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 31.03.2023.
//

import Foundation

enum Difficulties: String, CaseIterable {
    
    case easy = "easy"
    case medium = "medium"
    case hard = "hard"

    var id: Int {
        switch self {
        case .easy:
            return 1
        case .medium:
            return 2
        case .hard:
            return 3
        }
    }

}
