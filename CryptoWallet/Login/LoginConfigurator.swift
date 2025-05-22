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
        
    }
}
