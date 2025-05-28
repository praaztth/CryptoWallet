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
    
    let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "illustration_robot"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let loginTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Username"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 25
        textField.leftViewMode = .always
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 25
        textField.leftViewMode = .always
        return textField
    }()
    
    let loginButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = UIColor(red: 25/255, green: 28/255, blue: 50/255, alpha: 1)
        config.title = "Login"
        config.cornerStyle = .capsule
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
        addSubview(imageView)
        addSubview(loginTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        let orangeDark = UIColor(red: 247/255, green: 147/255, blue: 25/255, alpha: 1)
        let orangeLight = UIColor(red: 1, green: 235/255, blue: 228/255, alpha: 1)
        loginTextField.leftView = createLeftView(imageName: "person.circle.fill", firstColor: orangeDark, secondColor: orangeLight)
        let violetDark = UIColor(red: 159/255, green: 157/255, blue: 243/255, alpha: 1)
        let violetLight = UIColor(red: 235/255, green: 236/255, blue: 1, alpha: 1)
        passwordTextField.leftView = createLeftView(imageName: "lock.circle.fill", firstColor: violetDark, secondColor: violetLight)
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 23),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 287),
            imageView.widthAnchor.constraint(equalToConstant: 287),
            loginTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -15),
            loginTextField.heightAnchor.constraint(equalToConstant: 55),
            loginTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 25),
            loginTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -25),
            passwordTextField.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -25),
            passwordTextField.heightAnchor.constraint(equalToConstant: 55),
            passwordTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 25),
            passwordTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -25),
            loginButton.bottomAnchor.constraint(equalTo: keyboardLayoutGuide.topAnchor, constant: -120),
            loginButton.heightAnchor.constraint(equalToConstant: 55),
            loginButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 25),
            loginButton.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -25),
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
    
    func createLeftView(imageName: String, firstColor: UIColor, secondColor: UIColor) -> UIView {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 55, height: 55)))
        let imageView = UIImageView(frame: CGRect(x: 23/2, y: 23/2, width: 32, height: 32))
        
        let colorConfig = UIImage.SymbolConfiguration(paletteColors: [firstColor, secondColor])
        imageView.image = UIImage(systemName: imageName, withConfiguration: colorConfig)
        
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        return view
    }
}
