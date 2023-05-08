//
//  WelcomeViewModel.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 18.04.2023.
//

import Foundation
import Combine

class WelcomeViewModel: ObservableObject {
    private let userDefaults = UserDefaults.standard
    private var cancellable: AnyCancellable?

    @Published var user = ""
    @Published var isNameEntered = false
    @Published var showMenuView = false

    init() {
        checkIfNameEntered()
    }

    private func checkIfNameEntered() {
        if let name = userDefaults.string(forKey: UserDefaultsKeys.user.rawValue) {
            user = name
            isNameEntered = true
        }
    }

    enum UserDefaultsKeys: String {
        case user
    }
}
