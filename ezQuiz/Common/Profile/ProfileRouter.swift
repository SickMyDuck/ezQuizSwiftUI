//
//  ProfileRouter.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 19.04.2023.
//

import Foundation
import SwiftUI

class profileRouter {

    func openMenu(user: String) {
        Coordinator.navigateTo(destination: MenuView(viewModel: MenuViewModel()))
   }
}
