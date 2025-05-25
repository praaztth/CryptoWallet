//
//  CryptoListHeaderView.swift
//  CryptoWallet
//
//  Created by катенька on 23.05.2025.
//

import Foundation
import UIKit

class CryptoListHeaderView: UIView {
    weak var delegate: CryptoListHeaderButtonProtocol?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .white
        label.text = "Home"
        return label
    }()
    
    let advertisingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.text = "Affiliate program"
        return label
    }()
    
    let rightButton: UIButton = {
        let config = UIButton.Configuration.round(imageName: "ellipsis.circle.fill")
        
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.showsMenuAsPrimaryAction = true
        return button
    }()
    
    let advertisingButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Learn more"
        config.baseBackgroundColor = .white
        config.baseForegroundColor = .black
        
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        activateConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(titleLabel)
        addSubview(rightButton)
        addSubview(advertisingLabel)
        addSubview(advertisingButton)
        
        rightButton.menu = buildMenu()
    }
    
    func activateConstrains() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 25),
            rightButton.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            rightButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            
            advertisingLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 46),
            advertisingLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 25),
            advertisingButton.topAnchor.constraint(equalTo: advertisingLabel.bottomAnchor, constant: 12),
            advertisingButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25)
        ])
    }
    
    func buildMenu() -> UIMenu {
        let updateItem = UIAction(title: "Обновить", image: UIImage(systemName: "arrow.clockwise")) { _ in
            self.delegate?.updateButtonTapped()
        }
        
        let logoutItem = UIAction(title: "Выйти", image: UIImage(systemName: "rectangle.portrait.and.arrow.right")) { _ in
            self.delegate?.logoutButtonTapped()
        }
        
        let menu = UIMenu(children: [updateItem, logoutItem])
        return menu
    }
}
