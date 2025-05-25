//
//  CryptoInfoInteractor.swift
//  CryptoWallet
//
//  Created by катенька on 22.05.2025.
//

import Foundation

protocol CryptoInfoBusinessProcessable: AnyObject {
    
}

class CryptoInfoInteractor: CryptoInfoBusinessProcessable {
    var presenter: CryptoInfoPresentationProcessable
    
    init(presenter: CryptoInfoPresentationProcessable) {
        self.presenter = presenter
    }
}
