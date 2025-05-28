//
//  CryptoListWorker.swift
//  CryptoWallet
//
//  Created by катенька on 23.05.2025.
//

import Foundation

protocol CryptoListWorkingProcessable {
    func fetchData(completion: @escaping (Result<[Metrics], NetworkServiceError>) -> Void)
    func fetchImageData(id: String, completion: @escaping (Result<Data, NetworkServiceError>) -> Void)
}

class CryptoListWorker: CryptoListWorkingProcessable {
    let networkService = NetworkService.shared
    let cacheService = ImageCache.shared
    
    func fetchData(completion: @escaping (Result<[Metrics], NetworkServiceError>) -> Void) {
        networkService.fetchCryptoCurrencies { result in
            completion(result)
        }
    }
    
    func fetchImageData(id: String, completion: @escaping (Result<Data, NetworkServiceError>) -> Void) {
        if let imageData = cacheService.imageData(for: id) {
            completion(.success(imageData))
            return
        }
        
        networkService.fetchCurrencyImageData(id: id) { [weak self] result in
            switch result {
            case .success(let data):
                self?.cacheService.storeImageData(imageData: data, for: id)
            case .failure:
                break
            }
            
            completion(result)
        }
    }
}
