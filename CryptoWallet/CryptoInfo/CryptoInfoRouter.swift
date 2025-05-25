//
//  CryptoInfoRouter.swift
//  CryptoWallet
//
//  Created by катенька on 22.05.2025.
//

import Foundation

protocol CryptoInfoRoutingProcessable: AnyObject {
    func routeBackToCryptoList()
}

class CryptoInfoRouter: CryptoInfoRoutingProcessable {
    weak var viewController: CryptoInfoViewController?
    
    init(viewController: CryptoInfoViewController? = nil) {
        self.viewController = viewController
    }
    
    func routeBackToCryptoList() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
