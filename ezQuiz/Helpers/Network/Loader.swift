//
//  Loader.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 08.04.2023.
//

import Foundation

class Loader<modelT: Decodable> {
    func load(url: URL?, completion: @escaping (Result<modelT, Error>) -> Void) {
        if let url = url {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Error: \(error)")
                    completion(.failure(error))
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    print("Invalid response")
                    completion(.failure(NSError(domain: "Invalid response", code: 0, userInfo: nil)))
                    return
                }
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(modelT.self, from: data)
                        completion(.success(response))
                    } catch {
                        print("error decoding: \(error)")
                        completion(.failure(error))
                    }
                }
            }.resume()
        } else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
        }
    }
}
