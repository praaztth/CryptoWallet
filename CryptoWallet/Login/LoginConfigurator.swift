//
//  LoginConfigurator.swift
//  CryptoWallet
//
//  Created by катенька on 22.05.2025.
//

import Foundation

class LoginConfigurator {
    let authStorage: AuthStorageProtocol
    
    init(authStorage: AuthStorageProtocol) {
        self.authStorage = authStorage
    }
    
    func configure(viewController: LoginViewController) {
        let router = LoginRouter(viewController: viewController)
        let presenter = LoginPresenter(viewController: viewController)
        let interactor = LoginInteractor(presenter: presenter, authStorage: authStorage)
        
        viewController.router = router
        viewController.interactor = interactor
    }
}
