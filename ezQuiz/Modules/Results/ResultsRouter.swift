//
//  ResultsRouter.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 01.05.2023.
//

import Foundation
import SwiftUI

protocol ResultsRouterProtocol {
    func navigateTo<Destination: View>(destination: Destination, showNavBar: Bool)
}

class ResultsRouter: ResultsRouterProtocol {
    func navigateTo<Destination: View>(destination: Destination, showNavBar: Bool) {
         Coordinator.navigateTo(destination: destination, showNavBar: showNavBar)
    }
}
