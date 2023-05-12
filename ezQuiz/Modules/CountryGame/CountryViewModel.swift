//
//  CountryViewModel.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 09.05.2023.
//

import UIKit
import Combine
import SwiftUI

protocol CountryViewModelProtocol: ObservableObject, GameLogicProtocol {
    var country: String? { get }
    var answers: [CountryAnswer] { get }
    var correctAnswer: String { get }
    var selectedAnswer: String { get }

    func onAppear()
    func checkAnswer(_ answer: String)
    func getButtonColor(for answer: String) -> Color

}

final class CountryViewModel: GameLogic, CountryViewModelProtocol {

    @Published var country: String?
    @Published var answers: [CountryAnswer] = []
    @Published var correctAnswer: String = ""
    @Published var selectedAnswer: String = ""

    @Published private var questions: [CountryQuestion] = []
    @Published private var currentQuestion: CountryQuestion?
    @Published private var difficulty: Difficulties
    @Published private var wrongAnswersArray: [CountryAnswer] = []

    private let imageLoader: ImageLoader
    private let router: CountryRouterProtocol

    private var cancellables: Set<AnyCancellable> = .init()

    init(difficulty: Difficulties,
                  imageLoader: ImageLoader = KingfisherImageLoader.shared,
                  router: CountryRouterProtocol = CountryRouter()) {

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
            if Array(wrongAnswersArray.prefix(2).map{$0.answer}).contains(answer) {
                return false
            }
        }
        return true
    }

    // MARK: - PRIVATE METHODS

    // MARK: Data loading

    private func loadQuestions(amount: Int, difficulty: Difficulties) {
        // FIXME: decompose URL
        if let url = URL(string: "https://sickmyduck.ru/api/country_questions?amount=\(amount)&difficulty=\(difficulty)") {
            let loader = Loader<CountryQuestionItemModel>()
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

    private func loadImagesFromURLs(_ urls: [String]) {
        var answers = [String]()
        let publishers = urls.map { answer in
            answers.append(answer)
            return imageLoader.loadImage(from: URL(string: "https://sickmyduck.ru/flag_images/\(answer)")!)
        }
        Publishers.Sequence(sequence: publishers)
            .flatMap(maxPublishers: .max(10)) { $0 }
            .collect()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                guard case let .failure(error) = completion else { return }
                print("Error: \(error.localizedDescription)")
            }, receiveValue: { [weak self] images in
                self?.answers = images
                    .compactMap { $0 }
                    .enumerated()
                    .map { CountryAnswer(image: $0.element, answer: answers[$0.offset]) }
            })
            .store(in: &cancellables)
    }




    override func setupBindings() {

        super.setupBindings()

        $questions.sink { [weak self] question in
            guard !question.isEmpty else { return }
            self?.country = question[0].country
            self?.correctAnswer = question[0].correctAnswer
            self?.loadImagesFromURLs(question[0].answers)
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
            self?.country = $0?.country ?? ""
            self?.correctAnswer = $0?.correctAnswer ?? ""
            self?.selectedAnswer = ""
            self?.loadImagesFromURLs($0?.answers ?? [])
        }
        .store(in: &cancellables)

        $answers
            .map { answers in
                answers.filter { $0.answer != self.correctAnswer }
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

extension CountryViewModel {
    // MARK: - Router Methods

    func openMenu() {
        router.openMenu(user: User.getSavedUser() ?? "")
    }

    private func openResults() {
        router.openResultsView(points: self.correctAnswersCounter, difficulty: difficulty, gameType: .countryGame)
    }
}
