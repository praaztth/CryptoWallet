//
//  CryptoInfoView.swift
//  CryptoWallet
//
//  Created by катенька on 25.05.2025.
//

import Foundation
import UIKit

class CryptoInfoView: UIView {
    var delegate: CryptoInfoButtonsProtocol?
    
    let backButton: UIButton = {
        let config = UIButton.Configuration.round(imageName: "arrow.left.circle.fill")
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let logoutButton: UIButton = {
        let config = UIButton.Configuration.round(imageName: "rectangle.portrait.and.arrow.right.fill")
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 28)
        return label
    }()
    
    let stackHorizontal: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 4
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.backgroundColor = .systemGray4
        stack.layoutMargins = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layer.cornerRadius = 30
        return stack
    }()
    
    let percentView = CryptoInfoPercentChangeView()
    
    let footerView = CryptoInfoFooterView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemGray5
        setupViews()
        activateContrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: CryptoListModel.Currencies.CellViewModel, delegate: CryptoInfoButtonsProtocol) {
        nameLabel.text = viewModel.name + " (\(viewModel.symbol))"
        priceLabel.text = viewModel.price
        percentView.configure(percent: viewModel.percentChange, iconName: viewModel.iconName, iconColor: viewModel.iconColor.color)
        footerView.configure(marketCapitalization: viewModel.marketcap, circulatingSuply: viewModel.circulatingSupply)
        
        self.delegate = delegate
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }
    
    func setupViews() {
        percentView.translatesAutoresizingMaskIntoConstraints = false
        footerView.translatesAutoresizingMaskIntoConstraints = false
        
        [
            backButton,
            logoutButton,
            nameLabel,
            priceLabel,
            percentView,
            stackHorizontal,
            footerView
        ].forEach { addSubview($0) }
        
        let intervalButtons = createIntervalButtons()
        intervalButtons.forEach { button in
            stackHorizontal.addArrangedSubview(button)
        }
    }
    
    func activateContrains() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 35),
            backButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 25),
            logoutButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 35),
            logoutButton.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -25),
            nameLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            priceLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            percentView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
            percentView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackHorizontal.topAnchor.constraint(equalTo: percentView.bottomAnchor, constant: 20),
            stackHorizontal.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 25),
            stackHorizontal.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -25),
            stackHorizontal.heightAnchor.constraint(equalToConstant: 56),
            footerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            footerView.leftAnchor.constraint(equalTo: leftAnchor),
            footerView.rightAnchor.constraint(equalTo: rightAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 160)
        ])
    }
    
    func createIntervalButtons() -> [UIButton] {
        [
            "24H", "1W", "1Y", "ALL", "Point"
        ].map { title in
            let button = makeCustomButton(title: title)
            if title == "24H" {
                button.isSelected = true
                button.addTarget(self, action: #selector(oneDayButtonTapped), for: .touchUpInside)
            } else {
                button.addTarget(self, action: #selector(otherButtonTapped), for: .touchUpInside)
            }
            return button
        }
    }
    
    func makeCustomButton(title: String) -> UIButton {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .white
        config.baseForegroundColor = .black
        config.cornerStyle = .capsule
        let button = UIButton(configuration: config)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.setTitle(title, for: .normal)
        
        button.configurationUpdateHandler = { button in
            if button.isSelected {
                button.configuration?.baseBackgroundColor = .white
                button.configuration?.baseForegroundColor = .black
                
            } else {
                button.configuration?.baseBackgroundColor = .clear
                button.configuration?.baseForegroundColor = .systemGray
            }
        }
        return button
    }
    
    @objc func backButtonTapped() {
        delegate?.backButtonTapped()
    }
    
    @objc func logoutButtonTapped() {
        delegate?.logoutButtonTapped()
    }
    
    @objc func oneDayButtonTapped(_ sender: UIButton) {
        sender.isSelected = true
    }
    
    @objc func otherButtonTapped(_ sender: UIButton) {
        sender.isSelected = false
    }
}
