//
//  AuthStorage.swift
//  CryptoWallet
//
//  Created by катенька on 22.05.2025.
//

import Foundation

protocol AuthStorageProtocol {
    var isAuthorized: Bool { get set }
    func clear()
}

class AuthStorage: AuthStorageProtocol {
    static let shared = AuthStorage()
    
    private let key = "isAuthorized"
    
    var isAuthorized: Bool {
        get { UserDefaults.standard.bool(forKey: key) }
        set { UserDefaults.standard.set(newValue, forKey: key) }
    }
    
    func clear() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
