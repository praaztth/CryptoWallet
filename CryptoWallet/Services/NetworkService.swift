//
//  NetworkService.swift
//  CryptoWallet
//
//  Created by катенька on 22.05.2025.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchCryptoCurrencies(completion: @escaping (Result<Metrics, NetworkServiceError>) -> Void)
}

enum NetworkServiceError: Error {
    case invalidURL
    case requestFailed(String)
    case emptyResponce
    case decodingFailed
}

class NetworkService: NetworkServiceProtocol {
    static let shared = NetworkService()
    
    func fetchCryptoCurrencies(completion: @escaping (Result<Metrics, NetworkServiceError>) -> Void) {
        let dispatchGroup = DispatchGroup()
        
        Constants.currencies.forEach { currency in
            guard let url = currencyURL(currency: currency) else {
                completion(.failure(.invalidURL))
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, Responce, error in
                if let error = error {
                    completion(.failure(.requestFailed(error.localizedDescription)))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.emptyResponce))
                    return
                }
                
                do {
                    let metrics = try JSONDecoder().decode(Metrics.self, from: data)
                    completion(.success(metrics))
                } catch {
                    completion(.failure(.decodingFailed))
                }
                
                dispatchGroup.leave()
            }
            
            dispatchGroup.enter()
            task.resume()
        }
        
        dispatchGroup.notify(queue: .main) {
            print("All items are decoded")
        }
    }
    
    func currencyURL(currency: String) -> URL? {
        let url = URL(string: "\(Constants.apiURL)/\(currency)/metrics")
        return url
    }
}
