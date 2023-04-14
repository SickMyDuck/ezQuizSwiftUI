//
//  KingfisherImageLoader.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 13.04.2023.
//

import Combine
import UIKit
import Kingfisher

protocol ImageLoader {
    func loadImage(from url: URL) -> AnyPublisher<UIImage?, Error>
}

class KingfisherImageLoader: ImageLoader {
    static let shared = KingfisherImageLoader()

    private init() {}

    func loadImage(from url: URL) -> AnyPublisher<UIImage?, Error> {
        Future { promise in
            KingfisherManager.shared
                .retrieveImage(with: url) { result in
                    switch result {
                    case .success(let imageResult):
                        promise(.success(imageResult.image))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }
        }
        .eraseToAnyPublisher()
    }
}
