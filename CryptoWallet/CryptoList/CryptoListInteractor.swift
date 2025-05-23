//
//  CryptoListInteractor.swift
//  CryptoWallet
//
//  Created by катенька on 22.05.2025.
//

import Foundation

protocol CryptoListBusinessProcessable: AnyObject {
    func loadData()
    func logout()
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
            switch result {
            case .success(let results):
                let responce = CryptoListModel.Responce(isSuccess: true, metricts: results)
                self.presenter.presentSuccess(responce: responce)
            case .failure(let error):
                let responce = CryptoListModel.Responce(isSuccess: false, error: error)
                self.presenter.presentError(responce: responce)
            }
        }
    }
    
    func logout() {
        let authStorage = AuthStorage.shared
        authStorage.isAuthorized = false
        presenter.presentLoginRequired()
    }
}
