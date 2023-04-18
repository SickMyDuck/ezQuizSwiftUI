//
//  StartView.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 18.04.2023.
//

import SwiftUI
import Combine

struct StartView: View {
    @StateObject var userViewModel = UserViewModel()
    @StateObject var welcomeViewModel = WelcomeViewModel()

    var body: some View {
        if userViewModel.isUserFound {
            WelcomeView(viewModel: welcomeViewModel)
        } else {
            UserView(viewModel: userViewModel)
        }
    }
}
