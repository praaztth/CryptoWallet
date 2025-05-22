//
//  CryptoListInteractor.swift
//  CryptoWallet
//
//  Created by катенька on 22.05.2025.
//

import Foundation

protocol CryptoListBusinessProcessable: AnyObject {
    func loadData()
}

class CryptoListInteractor: CryptoListBusinessProcessable {
    var presenter: CryptoListPresentationProcessable
    var worker: CryptoListWorkingProcessable
    
    init(presenter: CryptoListPresentationProcessable) {
        self.presenter = presenter
        self.worker = CryptoListWorker()
    }
    
    func loadData() {
        worker.fetchData { result in
            print(result)
        }
    }
}
