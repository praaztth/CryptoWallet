//
//  NetworkService.swift
//  CryptoWallet
//
//  Created by катенька on 22.05.2025.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchCryptoCurrencies(completion: @escaping (Result<[Metrics], NetworkServiceError>) -> Void)
}

enum NetworkServiceError: Error {
    case invalidURL
    case requestFailed(String)
    case emptyResponce
    case decodingFailed
}

class NetworkService: NetworkServiceProtocol {
    static let shared = NetworkService()
    
    var results: [Metrics] = []
    var error: NetworkServiceError?
    
    func fetchCryptoCurrencies(completion: @escaping (Result<[Metrics], NetworkServiceError>) -> Void) {
        let dispatchGroup = DispatchGroup()
        let serialDispatchQueue = DispatchQueue(label: "sync.queue")
        
        Constants.currencies.forEach { currency in
            dispatchGroup.enter()
            
            guard let url = currencyURL(currency: currency) else {
//                completion(.failure(.invalidURL))
                error = .invalidURL
                dispatchGroup.leave()
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, Responce, error in
                if let error = error {
                    self.error = .requestFailed(error.localizedDescription)
                    dispatchGroup.leave()
//                    completion(.failure(.requestFailed(error.localizedDescription)))
                    return
                }
                
                guard let data = data else {
                    self.error = .emptyResponce
                    dispatchGroup.leave()
//                    completion(.failure(.emptyResponce))
                    return
                }
                
                do {
                    let metrics = try JSONDecoder().decode(Metrics.self, from: data)
                    // thread-safe array insertion
                    serialDispatchQueue.sync {
                        self.results.append(metrics)
                    }
//                    completion(.success(metrics))
                } catch {
                    self.error = .decodingFailed
//                    completion(.failure(.decodingFailed))
                }
                
                dispatchGroup.leave()
            }
            
            
            task.resume()
        }
        
        dispatchGroup.notify(queue: .main) {
            print("All items are decoded")
            if let error = self.error {
                completion(.failure(error))
            } else {
                completion(.success(self.results))
            }
        }
    }
    
    func currencyURL(currency: String) -> URL? {
        let url = URL(string: "\(Constants.apiURL)/\(currency)/metrics")
        return url
    }
}
