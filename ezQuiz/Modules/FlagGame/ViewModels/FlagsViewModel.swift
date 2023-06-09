//
//  FlagsViewModel.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 08.04.2023.
//

import UIKit
import Combine
import SwiftUI

protocol FlagsViewModelProtocol: ObservableObject, GameLogicProtocol {
    var flagUrl: URL? { get }
    var answers: [String] { get }
    var correctAnswer: String { get }
    var flagImage: UIImage { get }
    var selectedAnswer: String { get }

    func onAppear()
    func checkAnswer(_ answer: String)
    func getButtonColor(for answer: String) -> Color

}

final class FlagsViewModel: GameLogic, FlagsViewModelProtocol {

    @Published var flagUrl: URL?
    @Published var answers: [String] = []
    @Published var correctAnswer: String = ""
    @Published var flagImage: UIImage = UIImage(named: "Placeholder")!
    @Published var selectedAnswer: String = ""

    @Published private var questions: [FlagQuestion] = []
    @Published private var currentQuestion: FlagQuestion?
    @Published private var difficulty: Difficulties
    @Published private var wrongAnswersArray: [String] = []

    private let imageLoader: ImageLoader
    private let router: FlagsRouterProtocol

    private var cancellables: Set<AnyCancellable> = .init()

    init(difficulty: Difficulties,
                  imageLoader: ImageLoader = KingfisherImageLoader.shared,
                  router: FlagsRouterProtocol = FlagsRouter()) {

        self.difficulty = difficulty
        self.imageLoader = imageLoader
        self.router = router

        super.init()

        setupBindings()

    }

    convenience override init() {

        self.init(difficulty: .easy)

    }

    // MARK: - CONFIGURATIONS METHODS

    func onAppear() {
        loadQuestions(amount: 10, difficulty: self.difficulty)
    }

    // MARK: - VIEW MODEL METHODS

    func checkAnswer(_ answer: String) {

        selectedAnswer = answer

        if answer == correctAnswer {
            correctAnswersCounter += 1
        }

        isAnswered = true

        startNewQuestion()
    }

    func getButtonColor(for answer: String) -> Color {

        var buttonColor = Color.clear

        if answer == self.correctAnswer && !self.selectedAnswer.isEmpty {
            buttonColor = Color.green
        } else if self.selectedAnswer == answer {
            buttonColor = Color.red
        }

        return buttonColor

    }

    func isButtonAvailable(for answer: String) -> Bool {
        if isHintUsed && !self.wrongAnswersArray.isEmpty {
            if Array(wrongAnswersArray.prefix(2)).contains(answer) {
                return false
            }
        }
        return true
    }

    // MARK: - PRIVATE METHODS

    // MARK: Data loading

    private func loadQuestions(amount: Int, difficulty: Difficulties) {
        // FIXME: decompose URL
        if let url = URL(string: "https://sickmyduck.ru/api/flag_questions?amount=\(amount)&difficulty=\(difficulty)") {
            let loader = Loader<FlagQuestionItemModel>()
            loader.load(url: url) { result in
                switch result {
                case .success(let response):
                    print(response)
                    DispatchQueue.main.async {
                        self.questions = response.questions
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    private func loadImageFromURL(_ url: URL) {
        imageLoader.loadImage(from: url)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                guard case let .failure(error) = completion else { return }
                print("Error: \(error.localizedDescription)")
            }, receiveValue: { [weak self] image in
                self?.flagImage = image ?? UIImage(named: "Placeholder")!
            })
            .store(in: &cancellables)
    }


    override func setupBindings() {

        super.setupBindings()

        $questions.sink { [weak self] question in
            guard !question.isEmpty else { return }
            self?.flagUrl = URL(string: "https://sickmyduck.ru/flag_images/\(question[0].flagImage)")
            self?.correctAnswer = question[0].correctAnswer
            self?.answers = question[0].answers.shuffled()
            if let flagUrl = self?.flagUrl {
                self?.loadImageFromURL(flagUrl)
            }
        }
        .store(in: &cancellables)

        $questionsCounter.sink { [weak self] in
            if !(self?.questions.isEmpty ?? true) {
                if $0 == (self?.questions.endIndex ?? 0) {
                    self?.isQuizFinished = true
                } else {
                    self?.isHintUsed = false
                    self?.wrongAnswersArray = []
                    self?.currentQuestion = self?.questions[$0]
                    self?.isAnswered = false
                    self?.timeRemaining = 30.0
                }
            }
        }
        .store(in: &cancellables)

        $currentQuestion.sink { [weak self] in
            self?.flagUrl = URL(string: "https://sickmyduck.ru/flag_images/\($0?.flagImage ?? "")")
            self?.correctAnswer = $0?.correctAnswer ?? ""
            self?.answers = $0?.answers.shuffled() ?? []
            if let flagUrl = self?.flagUrl, let _ = $0?.flagImage {
                self?.loadImageFromURL(flagUrl)
            }
            self?.selectedAnswer = ""
        }
        .store(in: &cancellables)

        $answers
            .map { answers in
                answers.filter { $0 != self.correctAnswer }
            }
            .map { array in
                    array.shuffled()
                }
            .assign(to: &$wrongAnswersArray)

        $isQuizFinished
            .filter{ $0 }
            .sink { _ in
                self.openResults()
            }
            .store(in: &cancellables)

        $isHintUsed
            .filter { $0 }
            .sink { _ in
                self.shouldAnimate = true
            }
            .store(in: &cancellables)

        $isAnswered
            .filter { $0 }
            .sink { _ in
                self.shouldAnimate = false
            }
            .store(in: &cancellables)

        $needToOpenMenu
            .filter{ $0 }
            .sink { _ in
                self.openMenu()
            }
            .store(in: &cancellables)

        $timeOut
            .filter{ $0 }
            .sink { _ in
                self.checkAnswer("")
            }
            .store(in: &cancellables)
    }

}

extension FlagsViewModel {
    // MARK: - Router Methods

    func openMenu() {
        router.openMenu(user: User.getSavedUser() ?? "")
    }

    private func openResults() {
        router.openResultsView(points: self.correctAnswersCounter, difficulty: difficulty, gameType: GameType.flagGame)
    }
}
