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

    init() {
        checkIfNameEntered()
    }

    private func checkIfNameEntered() {
        if let name = userDefaults.string(forKey: UserDefaultsKeys.user.rawValue) {
            user = name
            isNameEntered = true
        }
    }

    func deleteUser() {
        userDefaults.removeObject(forKey: UserDefaultsKeys.user.rawValue)
    }

    enum UserDefaultsKeys: String {
        case user
    }
}
