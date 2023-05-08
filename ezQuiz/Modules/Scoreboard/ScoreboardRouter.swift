//
//  ScoreboardRouter.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 26.04.2023.
//

import Foundation
import SwiftUI

protocol ScoreboardRouterProtocol {
    func backToMenu<Destination: View>(destination: Destination)
}

class ScoreboardRouter: DifficultyRouterProtocol {
     func backToMenu<Destination: View>(destination: Destination) {
         Coordinator.navigateTo(destination: destination, backButton: true)
    }
}
