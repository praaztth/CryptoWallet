//
//  LoginPresenter.swift
//  CryptoWallet
//
//  Created by катенька on 22.05.2025.
//

import Foundation

protocol LoginPresentationProcessable: AnyObject {
    func presentLoginSuccess()
    func presentLoginFailure(responce: LoginModel.Responce)
}

class LoginPresenter: LoginPresentationProcessable {
    weak var viewController: LoginDisplayProcessable?
    
    init(viewController: LoginDisplayProcessable) {
        self.viewController = viewController
    }
    
    func presentLoginSuccess() {
        viewController?.showLoginSuccess()
    }
    
    func presentLoginFailure(responce: LoginModel.Responce) {
        var errorMessage: String = ""
        
        switch responce.message {
        case "InvalidCredentialsError":
            errorMessage = "Введено неверное имя пользователя или пароль"
        default:
            errorMessage = "Что-то пошло не так..."
        }
        
        let viewModel = LoginModel.ViewModel(errorMessage: errorMessage)
        viewController?.showLoginFailure(viewModel: viewModel)
    }
}
