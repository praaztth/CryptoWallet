//
//  CryptoListWorker.swift
//  CryptoWallet
//
//  Created by катенька on 23.05.2025.
//

import Foundation

protocol CryptoListWorkingProcessable {
    func fetchData(completion: @escaping (Result<Metrics, NetworkServiceError>) -> Void)
}

class CryptoListWorker: CryptoListWorkingProcessable {
    let service = NetworkService.shared
    
    func fetchData(completion: @escaping (Result<Metrics, NetworkServiceError>) -> Void) {
        service.fetchCryptoCurrencies { result in
            completion(result)
        }
    }
}
