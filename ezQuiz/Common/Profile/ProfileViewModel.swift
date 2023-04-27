//
//  ProfileViewModel.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 19.04.2023.
//

import SwiftUI
import Combine

class ProfileViewModel: ObservableObject {
    @Published var user: String = ""

    private let router = profileRouter()

    private var cancellables = Set<AnyCancellable>()

    func loadUser() {
        user = User.getSavedUser() ?? ""
    }

    func saveUserName() {
        User.saveUser(user: user)
    }

    func openMenu() {
        router.openMenu(user: user)
    }
}
