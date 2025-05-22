//
//  CryptoListPresenter.swift
//  CryptoWallet
//
//  Created by катенька on 22.05.2025.
//

import Foundation

protocol CryptoListPresentationProcessable: AnyObject {
    
}

class CryptoListPresenter: CryptoListPresentationProcessable {
    weak var viewController: CryptoListDisplayProcessable?
    
    init(viewController: CryptoListDisplayProcessable? = nil) {
        self.viewController = viewController
    }
}
