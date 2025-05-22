//
//  CryptoListRouter.swift
//  CryptoWallet
//
//  Created by катенька on 22.05.2025.
//

import Foundation

protocol CryptoListRoutingProcessable: AnyObject {
    
}

class CryptoListRouter: CryptoListRoutingProcessable {
    weak var viewController: CryptoListViewController?
    
    init(viewController: CryptoListViewController? = nil) {
        self.viewController = viewController
    }
}
