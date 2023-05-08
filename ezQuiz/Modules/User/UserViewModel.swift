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
    var showNextView : Bool { get }
}

class UserViewModel: UserViewModelProtocol, ObservableObject {

    var isUserFound: Bool = false

    @Published var user = ""
    @Published var showNextView = false

    private var cancellables = Set<AnyCancellable>()

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
