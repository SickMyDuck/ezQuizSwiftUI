//
//  ResultsViewModel.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 01.05.2023.
//

import Foundation
import Combine
import SwiftUI

class ResultsViewModel: ObservableObject {

    @Published var points: Int
    @Published var showNewRecord: Bool = false
    var items: [ResultItem] = []
    
    private let coreDataHelper = CoreDataHelper()

    @Published private var difficulty: Difficulties
    @Published private var gameType: GameType

    init(points: Int, difficulty: Difficulties, gameType: GameType) {
        self.points = points
        self.difficulty = difficulty
        self.gameType = gameType

        setupBindings()
    }

    private let router = ResultsRouter()

    private var cancellables = Set<AnyCancellable>()

    // MARK: - View Model Methods

    func onAppear() {
        saveResultsIfNeeded()
    }

    func saveResultsIfNeeded() {
        let quizResult = coreDataHelper.getRecords(for: difficulty, and: gameType)
        var savedPoints = 0
        if !quizResult.isEmpty {
            savedPoints = Int(quizResult[0].result)
        }
        if savedPoints < points {
            showNewRecord = true
            coreDataHelper.deleteRecord(difficulty: difficulty, gameType: gameType)
            coreDataHelper.saveRecord(date: Date(), difficulty: difficulty, gameType: gameType, result: points)
        }
        
    }

    // MARK: - Private Methods

    private func setupBindings() {
        $difficulty
            .sink { difficulty in
                self.items = [
                    ResultItem(title: "Try again", destination: self.gameType == .flagGame ? AnyView(FlagsView(viewModel: FlagsViewModel(difficulty: difficulty))) : AnyView(CountryView(viewModel: CountryViewModel(difficulty: difficulty))), showNavBar: true),
                    ResultItem(title: "Choose difficulty", destination: AnyView(DifficultyView(with: DifficultyViewModel(gameType: self.gameType))), showNavBar: false),
                    ResultItem(title: "Main menu", destination: AnyView(MenuView(viewModel: MenuViewModel())), showNavBar: false)
                ]
            }
            .store(in: &cancellables)
    }

}

extension ResultsViewModel {
    // MARK: - ROUTER METHODS
    func navigateTo<Destination>(destination: Destination, showNavBar: Bool) where Destination : View {
        router.navigateTo(destination: destination, showNavBar: showNavBar)
    }
}
