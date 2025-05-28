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
                error = .invalidURL
                dispatchGroup.leave()
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, Responce, error in
                if let error = error {
                    self.error = .requestFailed(error.localizedDescription)
                    dispatchGroup.leave()
                    return
                }
                
                guard let data = data else {
                    self.error = .emptyResponce
                    dispatchGroup.leave()
                    return
                }
                
                do {
                    let metrics = try JSONDecoder().decode(Metrics.self, from: data)
                    // thread-safe array insertion
                    serialDispatchQueue.sync {
                        self.results.append(metrics)
                    }
                } catch {
                    self.error = .decodingFailed
                }
                
                dispatchGroup.leave()
            }
            
            task.resume()
        }
        
        dispatchGroup.notify(queue: .main) {
            if let error = self.error {
                completion(.failure(error))
            } else {
                completion(.success(self.results))
            }
            
            self.results = []
            self.error = nil
        }
    }
    
    func fetchCurrencyImageData(id: String, completion: @escaping (Result<Data, NetworkServiceError>) -> Void) {
        guard let url = currencyImageURL(currencyId: id) else {
            let error = NetworkServiceError.invalidURL
            completion(.failure(error))
            return
        }
        
        DispatchQueue.global(qos: .utility).async {
            do {
                let imageData = try Data(contentsOf: url)
                completion(.success(imageData))
            } catch {
                completion(.failure(NetworkServiceError.requestFailed(error.localizedDescription)))
            }
        }
    }
    
    func currencyURL(currency: String) -> URL? {
        let url = URL(string: "\(Constants.apiURL)/\(currency)/metrics")
        return url
    }
    
    func currencyImageURL(currencyId: String) -> URL? {
        let url = URL(string: "\(Constants.imageURL)/\(currencyId)/64.png")
        return url
    }
}
