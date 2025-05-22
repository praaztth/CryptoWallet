//
//  LoginInteractor.swift
//  CryptoWallet
//
//  Created by катенька on 22.05.2025.
//

import Foundation

protocol LoginBusinessProcessable: AnyObject {
    func login(request: Model.Request)
}

class LoginInteractor: LoginBusinessProcessable {
    var presenter: LoginPresentationProcessable
    var worker: LoginWorkingProcessable
    let authStorage: AuthStorageProtocol
    
    init(presenter: LoginPresentationProcessable, authStorage: AuthStorageProtocol) {
        self.presenter = presenter
        self.worker = LoginWorker()
        self.authStorage = authStorage
    }
    
    func login(request: Model.Request) {
        let username = request.username
        let password = request.password
        
        self.worker.login(username: username, password: password) { isSuccess, message in
            if isSuccess {
                authStorage.isAuthorized = true
                self.presenter.presentLoginSuccess()
            } else {
                let responce = Model.Responce(message: message ?? "")
                self.presenter.presentLoginFailure(responce: responce)
            }
        }
        
    }
}
