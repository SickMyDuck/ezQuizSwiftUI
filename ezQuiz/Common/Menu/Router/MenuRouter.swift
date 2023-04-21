//
//  MenuRouter.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 05.04.2023.
//

import Foundation
import SwiftUI

protocol MenuRouterProtocol {
    func navigateTo<Destination: View>(destination: Destination)
}

class MenuRouter: MenuRouterProtocol {
     func navigateTo<Destination: View>(destination: Destination) {
         Coordinator.navigateTo(destination: destination)
    }
}
