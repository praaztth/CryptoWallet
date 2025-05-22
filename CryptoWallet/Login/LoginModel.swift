//
//  LoginModel.swift
//  CryptoWallet
//
//  Created by катенька on 22.05.2025.
//

import Foundation

struct Model {
    struct Request {
        let username: String
        let password: String
    }
    
    struct Responce {
        let message: String
    }
    
    struct ViewModel {
        let errorMessage: String
    }
}
