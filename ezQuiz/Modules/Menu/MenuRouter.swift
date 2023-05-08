//
//  MenuRouter.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 05.04.2023.
//

import Foundation
import SwiftUI

protocol MenuRouterProtocol {
    func navigateTo<Destination: View>(destination: Destination, showNavBar: Bool)
}

class MenuRouter: MenuRouterProtocol {
    func navigateTo<Destination: View>(destination: Destination, showNavBar: Bool) {
         Coordinator.navigateTo(destination: destination, showNavBar: showNavBar)
    }
}
