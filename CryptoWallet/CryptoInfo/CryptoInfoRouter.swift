//
//  CryptoInfoRouter.swift
//  CryptoWallet
//
//  Created by катенька on 22.05.2025.
//

import Foundation

protocol CryptoInfoRoutingProcessable: AnyObject {
    func routeBackToCryptoList()
    func routeToLogin()
}

class CryptoInfoRouter: CryptoInfoRoutingProcessable {
    weak var viewController: CryptoInfoViewController?
    
    init(viewController: CryptoInfoViewController? = nil) {
        self.viewController = viewController
    }
    
    func routeBackToCryptoList() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func routeToLogin() {
        let authStorage = AuthStorage.shared
        let configurator = LoginConfigurator(authStorage: authStorage)
        let vc = LoginViewController(configurator: configurator)
        viewController?.view.window?.rootViewController = vc
    }
}
