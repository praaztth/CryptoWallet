//
//  LoginPresenter.swift
//  CryptoWallet
//
//  Created by катенька on 22.05.2025.
//

import Foundation

protocol PresentationProcessable: AnyObject {
    func presentLoginSuccess()
    func presentLoginFailure(responce: Model.Responce)
}

class LoginPresenter: PresentationProcessable {
    weak var viewController: DisplayProcessable?
    
    init(viewController: DisplayProcessable) {
        self.viewController = viewController
    }
    
    func presentLoginSuccess() {
        viewController?.showLoginSuccess()
    }
    
    func presentLoginFailure(responce: Model.Responce) {
        var errorMessage: String = ""
        
        switch responce.message {
        case "InvalidCredentialsError":
            errorMessage = "Введено неверное имя пользователя или пароль"
        default:
            errorMessage = "Что-то пошло не так..."
        }
        
        let viewModel = Model.ViewModel(errorMessage: errorMessage)
        viewController?.showLoginFailure(viewModel: viewModel)
    }
}
