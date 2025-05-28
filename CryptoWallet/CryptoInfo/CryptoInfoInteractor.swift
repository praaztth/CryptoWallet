//
//  CryptoInfoInteractor.swift
//  CryptoWallet
//
//  Created by катенька on 22.05.2025.
//

import Foundation

protocol CryptoInfoBusinessProcessable: AnyObject {
    func logout()
}

class CryptoInfoInteractor: CryptoInfoBusinessProcessable {
    var presenter: CryptoInfoPresentationProcessable
    
    init(presenter: CryptoInfoPresentationProcessable) {
        self.presenter = presenter
    }
    
    func logout() {
        let authStorage = AuthStorage.shared
        authStorage.isAuthorized = false
        presenter.presentLoginRequired()
    }
}
