//
//  DifficultyRouter.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 23.04.2023.
//

import Foundation
import SwiftUI

protocol DifficultyRouterProtocol {
    func backToMenu<Destination: View>(destination: Destination)
}

class DifficultyRouter: DifficultyRouterProtocol {
     func backToMenu<Destination: View>(destination: Destination) {
         Coordinator.navigateTo(destination: destination, backButton: true)
    }
}
