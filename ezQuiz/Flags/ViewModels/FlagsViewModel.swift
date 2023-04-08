//
//  FlagsViewModel.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 08.04.2023.
//

import Foundation
import Combine

protocol FlagsViewModelProtocol: ObservableObject {

}

class FlagsViewModel: FlagsViewModelProtocol {

    // MARK: Data loading

    func loadQuestions() {
        if let url = URL(string: "https://sickmyduck.ru/api/get_image/russia/") {
            let loader = Loader<QuestionsModel>()
            loader.load(url: url) { result in
                switch result {
                case .success(let response):
                    print(response)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }


}
