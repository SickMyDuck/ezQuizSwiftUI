//
//  GameProtocol+Game.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 09.05.2023.
//

import Foundation
import SwiftUI

protocol GameLogicProtocol: ObservableObject {

    var correctAnswersCounter: Int { get }
    var isAnswered: Bool { get set}
    var isQuizFinished: Bool { get set }
    var isMenuVisible: Bool { get set }
    var questionsCounter: Int { get }
    var isInformationVisible: Bool { get set }
    var isHintUsed: Bool { get set }
    var timeRemaining: Double { get set }
    var needToOpenMenu: Bool { get set }
    var timeOut: Bool { get set }
}

class GameLogic {
    @Published var correctAnswersCounter: Int = 0
    @Published var questionsCounter: Int = 0
    @Published var isAnswered: Bool = false
    @Published var isQuizFinished: Bool = false
    @Published var isMenuVisible: Bool = false
    @Published var isHintUsed: Bool = false
    @Published var timeRemaining = 30.0
    @Published var shouldAnimate: Bool = false
    @Published var isInformationVisible: Bool = false
    @Published var needToOpenMenu: Bool = false
    @Published var timeOut: Bool = false

    init() {
        
    }

    func startNewQuestion() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.increaseQuestionsCounter()
        }
    }

    func increaseQuestionsCounter() {
        questionsCounter += 1
    }

    func setupBindings() {

    }
    
}

