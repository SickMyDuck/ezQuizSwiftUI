//
//  UserViewModel.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 18.04.2023.
//

import Foundation
import Combine

protocol UserViewModelProtocol {
    var isUserFound: Bool { get }
    var user: String { get }
}

class UserViewModel: UserViewModelProtocol, ObservableObject {

    var isUserFound: Bool = false
    private var cancellables = Set<AnyCancellable>()

    @Published var user = ""

    init() {
        if let savedUser = getSavedUser() {
            user = savedUser
            isUserFound = true
        }
    }
    
    func saveUser() {
        User.saveUser(user: user)
    }

    func getSavedUser() -> String? {
        User.getSavedUser()
    }

}
