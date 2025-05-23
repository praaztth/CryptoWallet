//
//  CryptoListRouter.swift
//  CryptoWallet
//
//  Created by катенька on 22.05.2025.
//

import Foundation

protocol CryptoListRoutingProcessable: AnyObject {
    func routeToLogin()
}

class CryptoListRouter: CryptoListRoutingProcessable {
    weak var viewController: CryptoListViewController?
    
    init(viewController: CryptoListViewController? = nil) {
        self.viewController = viewController
    }
    
    func routeToLogin() {
        let authStorage = AuthStorage.shared
        let configurator = LoginConfigurator(authStorage: authStorage)
        let vc = LoginViewController(configurator: configurator)
        viewController?.view.window?.rootViewController = vc
    }
}
