//
//  LoginViewController.swift
//  CryptoWallet
//
//  Created by катенька on 22.05.2025.
//

import Foundation
import UIKit

protocol DisplayProcessable: AnyObject {
    func showLoginSuccess()
    func showLoginFailure(viewModel: Model.ViewModel)
}

protocol LoginDelegate: AnyObject {
    func buttonTapped()
}

class LoginViewController: UIViewController, DisplayProcessable, LoginDelegate {
    private let loginView = LoginView()
    
    var router: RoutingProcessable?
    var interactor: BusinessProcessable?
    
    init(configurator: LoginConfigurator) {
        super.init(nibName: nil, bundle: nil)
        configurator.configure(viewController: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = loginView
        loginView.delegate = self
        hideKeyboardWhenTappedAround()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func buttonTapped() {
        loginView.desableControls()
        let request = Model.Request(username: loginView.username, password: loginView.password)
        interactor?.login(request: request)
    }
    
    func showLoginSuccess() {
        router?.routeToCryptoList()
    }
    
    func showLoginFailure(viewModel: Model.ViewModel) {
        let alert = UIAlertController(title: "Не удалось войти", message: viewModel.errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Повторить", style: .default) { _ in
            print("Повторить")
        })
        alert.addAction(UIAlertAction(title: "Отменить", style: .cancel) { _ in
            self.loginView.clearAllFields()
            print("Отменить")
        })
        
        loginView.enableControls()
        present(alert, animated: true)
    }
}

extension LoginViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view is UIControl {
            return false
        }
        
        return true
    }
}
