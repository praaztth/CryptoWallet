//
//  LoginWorker.swift
//  CryptoWallet
//
//  Created by катенька on 22.05.2025.
//

import Foundation

protocol LoginWorkingProcessable: AnyObject {
    func login(username: String, password: String, callback: (Bool, String?) -> Void)
}

class LoginWorker: LoginWorkingProcessable {
    func login(username: String, password: String, callback: (Bool, String?) -> Void) {
        if username == "1234", password == "1234" {
            callback(true, nil)
        } else {
            callback(false, "InvalidCredentialsError")
        }
    }
}
