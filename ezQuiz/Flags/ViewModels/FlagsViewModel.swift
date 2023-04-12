//
//  FlagsViewModel.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 08.04.2023.
//

import Foundation
import Combine

protocol FlagsViewModelProtocol: ObservableObject {
    var flagUrl: URL? { get }
    var answers: [String] { get }
    var correctAnswer: String { get }

    func onAppear()
    func increaseQuestionsCounter()
}

class FlagsViewModel: FlagsViewModelProtocol {

    @Published var flagUrl: URL?
    @Published var answers: [String] = []
    @Published var correctAnswer: String = ""

    @Published private var questions: [Question] = []
    @Published private var currentQuestion: Question?
    @Published private var questionsCounter: Int = 0

    private var cancellables: Set<AnyCancellable> = .init()

    required init() {

        setupBindings()

    }

    // MARK: Data loading

    func loadQuestions(amount: Int, difficulty: Difficulties) {
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

    func setupBindings() {

        $questionsCounter.sink { [weak self] in
            if !(self?.questions.isEmpty ?? true) {
                self?.currentQuestion = self?.questions[$0]
            }
        }
        .store(in: &cancellables)
        $currentQuestion.sink { [weak self] in
            self?.flagUrl = URL(string: "https://sickmyduck.ru/flagImages/\(String(describing: $0?.flagImage))")
            self?.answers = $0?.answers ?? []
            self?.correctAnswer = $0?.correctAnswer ?? ""
        }
        .store(in: &cancellables)
    }

    func increaseQuestionsCounter() {
        questionsCounter += 1
    }

    func onAppear() {
        loadQuestions(amount: 10, difficulty: .easy)
    }

}
