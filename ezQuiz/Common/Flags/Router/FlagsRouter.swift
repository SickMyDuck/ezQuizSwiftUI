//
//  FlagsRouter.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 08.04.2023.
//

import UIKit

protocol FlagsRouterProtocol {
    func openMenu(user: String)
}

class FlagsRouter: FlagsRouterProtocol {
    func openMenu(user: String) {
        Coordinator.navigateTo(destination: MenuView(viewModel: MenuViewModel(user: user)))
   }
}
