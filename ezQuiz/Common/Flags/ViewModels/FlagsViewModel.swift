//
//  FlagsViewModel.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 08.04.2023.
//

import UIKit
import Combine
import SwiftUI

protocol FlagsViewModelProtocol: ObservableObject {
    var flagUrl: URL? { get }
    var answers: [String] { get }
    var correctAnswer: String { get }
    var flagImage: UIImage { get }
    var correctAnswersCounter: Int { get }
    var isAnswered: Bool { get set}
    var isQuizFinished: Bool { get set }
    var questionsCounter: Int { get }
    var selectedAnswer: String { get }
    var isInformationVisible: Bool { get set }
    var isHintUsed: Bool { get set }
    var timeRemaining: Double { get set }

    func onAppear()
    func checkAnswer(_ answer: String)
    func getButtonColor(for answer: String) -> Color
}

class FlagsViewModel: FlagsViewModelProtocol {

    @Published var flagUrl: URL?
    @Published var answers: [String] = []
    @Published var correctAnswer: String = ""
    @Published var flagImage: UIImage = UIImage(named: "Placeholder")!
    @Published var correctAnswersCounter: Int = 0
    @Published var isAnswered: Bool = false
    @Published var questionsCounter: Int = 0
    @Published var isQuizFinished: Bool = false
    @Published var isMenuVisible: Bool = false
    @Published var selectedAnswer: String = ""
    @Published var isInformationVisible: Bool = false
    @Published var isHintUsed: Bool = false
    @Published var timeRemaining = 30.0

    @Published private var questions: [Question] = []
    @Published private var currentQuestion: Question?
    @Published private var difficulty: Difficulties
    @Published private var wrongAnswersArray: [String] = []

    private let imageLoader: ImageLoader
    private let router = FlagsRouter()

    private var cancellables: Set<AnyCancellable> = .init()

    required init(difficulty: Difficulties,
                  imageLoader: ImageLoader = KingfisherImageLoader.shared) {

        self.difficulty = difficulty
        self.imageLoader = imageLoader

        setupBindings()

    }

    convenience init() {

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
            let loader = Loader<QuestionItemModel>()
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

    private func startNewQuestion() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.increaseQuestionsCounter()
        }
    }

    private func increaseQuestionsCounter() {
        questionsCounter += 1
    }

    private func setupBindings() {

        $questions.sink { [weak self] question in
            guard !question.isEmpty else { return }
            self?.flagUrl = URL(string: "https://sickmyduck.ru/flagImages/\(question[0].flagImage)")
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
            self?.flagUrl = URL(string: "https://sickmyduck.ru/flagImages/\($0?.flagImage ?? "")")
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
