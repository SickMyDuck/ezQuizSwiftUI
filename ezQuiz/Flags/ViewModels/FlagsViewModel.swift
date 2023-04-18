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
    var isAnswered: Bool { get }
    var isQuizFinished: Bool { get }
    var questionsCounter: Int { get }

    func onAppear()
    func checkAnswer(answer: String)
}

class FlagsViewModel: FlagsViewModelProtocol {

    private let imageLoader: ImageLoader


    @Published var flagUrl: URL?
    @Published var answers: [String] = []
    @Published var correctAnswer: String = ""
    @Published var flagImage: UIImage = UIImage(named: "Placeholder")!
    @Published var correctAnswersCounter: Int = 0
    @Published var isAnswered: Bool = false
    @Published var questionsCounter: Int = 0
    @Published var isQuizFinished: Bool = false
    @Published var buttonBackgroundColor: Color = Color.blue
    @Published var buttonForegroundColor: Color = Color.white



    @Published private var questions: [Question] = []
    @Published private var currentQuestion: Question?


    private var cancellables: Set<AnyCancellable> = .init()

    required init(imageLoader: ImageLoader = KingfisherImageLoader.shared) {

        self.imageLoader = imageLoader

        setupBindings()

    }

    func checkAnswer(answer: String) {
        if answer == correctAnswer {
            correctAnswersCounter += 1
            buttonBackgroundColor = Color.green
        } else {
            buttonBackgroundColor = Color.red
        }

        isAnswered = true

        startNewQuestion()
    }

    private func startNewQuestion() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.increaseQuestionsCounter()
        }
    }

    private func increaseQuestionsCounter() {
        questionsCounter += 1
    }

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


    private func setupBindings() {

            $questions.sink { [weak self] question in
                guard !question.isEmpty else { return }
                self?.flagUrl = URL(string: "https://sickmyduck.ru/flagImages/\(question[0].flagImage)")
                self?.answers = question[0].answers
                self?.correctAnswer = question[0].correctAnswer
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
                        self?.currentQuestion = self?.questions[$0]
                        self?.isAnswered = false
                    }
                }
                self?.buttonBackgroundColor = Color.blue
            }
            .store(in: &cancellables)

            $currentQuestion.sink { [weak self] in
                self?.flagUrl = URL(string: "https://sickmyduck.ru/flagImages/\($0?.flagImage ?? "")")
                self?.answers = $0?.answers ?? []
                self?.correctAnswer = $0?.correctAnswer ?? ""
                if let flagUrl = self?.flagUrl {
                    self?.loadImageFromURL(flagUrl)
                }
            }
            .store(in: &cancellables)
        }

    func onAppear() {
        loadQuestions(amount: 10, difficulty: .easy)
    }

}
