//
//  CryptoInfoPresenter.swift
//  CryptoWallet
//
//  Created by катенька on 22.05.2025.
//

import Foundation

protocol CryptoInfoPresentationProcessable: AnyObject {
    func presentLoginRequired()
}

class CryptoInfoPresenter: CryptoInfoPresentationProcessable {
    weak var viewController: CryptoInfoViewController?
    
    init(viewController: CryptoInfoViewController? = nil) {
        self.viewController = viewController
    }
    
    func presentLoginRequired() {
        viewController?.displayLoginRequired()
    }
}
