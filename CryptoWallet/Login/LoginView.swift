//
//  LoginView.swift
//  CryptoWallet
//
//  Created by катенька on 22.05.2025.
//

import Foundation
import UIKit

class LoginView: UIView {
    weak var delegate: LoginDelegate?
    
    var username: String {
        return loginTextField.text ?? ""
    }
    
    var password: String {
        return passwordTextField.text ?? ""
    }
    
    let loginTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Login"
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let loginButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Login"
        config.buttonSize = .large
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        activateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = .systemGroupedBackground
        addSubview(loginTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            loginTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -20),
            loginTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            passwordTextField.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -20),
            passwordTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            loginButton.bottomAnchor.constraint(equalTo: keyboardLayoutGuide.topAnchor, constant: -20),
            loginButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    @objc func buttonTapped() {
        delegate?.buttonTapped()
    }
    
    func desableControls() {
        loginTextField.isEnabled = false
        passwordTextField.isEnabled = false
        loginButton.isEnabled = false
    }
    
    func enableControls() {
        loginTextField.isEnabled = true
        passwordTextField.isEnabled = true
        loginButton.isEnabled = true
    }
    
    func clearAllFields() {
        loginTextField.text = ""
        passwordTextField.text = ""
    }
}
