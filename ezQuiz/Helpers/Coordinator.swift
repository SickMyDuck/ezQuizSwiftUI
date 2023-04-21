//
//  Coordinator.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 19.04.2023.
//

import Foundation
import SwiftUI

class Coordinator {
    static func navigateTo<Destination: View>(destination: Destination) {
        let view = UIHostingController(rootView: destination.environment(\.colorScheme, .dark))
        let navigationController = UINavigationController(rootViewController: view)
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}
