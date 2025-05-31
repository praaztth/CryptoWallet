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
            
            fetchAndDecodeData(url: url) { (result: Result<Metrics, NetworkServiceError>) in
                switch result {
                case .success(let currency):
                    // thread-safe array insertion
                    serialDispatchQueue.sync {
                        self.results.append(currency)
                    }
                case .failure(let error):
                    self.error = error
                }
                
                dispatchGroup.leave()
            }
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
        
        fetchData(url: url) { (result: Result<Data, NetworkServiceError>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchAndDecodeData<T: Decodable>(url: URL, completion: @escaping (Result<T, NetworkServiceError>) -> Void) {
        fetchData(url: url) { (result: Result<Data, NetworkServiceError>) in
            switch result {
            case .success(let encodedData):
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: encodedData)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.decodingFailed))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchData(url: URL, completion: @escaping (Result<Data, NetworkServiceError>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, Responce, error in
            if let error = error {
                completion(.failure(.requestFailed(error.localizedDescription)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.emptyResponce))
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
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
