//
//  Coordinator.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 19.04.2023.
//

import Foundation
import SwiftUI

class Coordinator {

    static func navigateTo<Destination: View>(destination: Destination, backButton: Bool = false, showNavBar: Bool = false) {
        let view = UIHostingController(rootView: destination.environment(\.colorScheme, .dark))
        let navigationController = UINavigationController(rootViewController: view)
        if !showNavBar {
            navigationController.setNavigationBarHidden(true, animated: false)
        }
        let transition = CATransition()
        transition.type = .push
        transition.subtype = backButton ? .fromLeft : .fromRight
        navigationController.view.layer.add(transition, forKey: kCATransition)

        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }



}
