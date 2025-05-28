//
//  CryptoListTableViewCell.swift
//  CryptoWallet
//
//  Created by катенька on 23.05.2025.
//

import Foundation
import UIKit

class CryptoListTableViewCell: UITableViewCell {
    let nameLabel = UILabel()
    let priceLabel = UILabel()
    let symbolLabel = UILabel()
    let percentView = CryptoInfoPercentChangeView()
    
    let imageCurrencyView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let pricePercentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.alignment = .trailing
        stackView.distribution = .fill
        return stackView
    }()
    
    var isImageLoaded = false
    
    override func prepareForReuse() {
        imageCurrencyView.image = UIImage(systemName: "circle.dotted")
        isImageLoaded = false
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        activateContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(name: String, symbol: String, price: String, percentChange: String, iconName: String, iconColor: UIColor) {
        nameLabel.text = name
        symbolLabel.text = symbol
        priceLabel.text = price
        percentView.configure(percent: percentChange, iconName: iconName, iconColor: iconColor)
        imageCurrencyView.image = UIImage(systemName: "circle.dotted")
    }
    
    func setupViews() {
        backgroundColor = .systemGroupedBackground
        
        nameLabel.applyTableViewCellTitle()
        priceLabel.applyTableViewCellTitle()
        symbolLabel.applyTableViewCellSubtitle()
        
        percentView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(nameLabel)
        addSubview(symbolLabel)
        addSubview(pricePercentStackView)
        addSubview(imageCurrencyView)
        
        pricePercentStackView.addArrangedSubview(priceLabel)
        pricePercentStackView.addArrangedSubview(percentView)
    }
    
    func setImage(image: UIImage) {
        imageCurrencyView.image = image
        isImageLoaded = true
    }
    
    func activateContraints() {
        NSLayoutConstraint.activate([
            imageCurrencyView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageCurrencyView.leftAnchor.constraint(equalTo: leftAnchor),
            imageCurrencyView.heightAnchor.constraint(equalToConstant: 50),
            imageCurrencyView.widthAnchor.constraint(equalToConstant: 50),
            nameLabel.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: imageCurrencyView.trailingAnchor, constant: 19),
            pricePercentStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            pricePercentStackView.rightAnchor.constraint(equalTo: rightAnchor),
            
            symbolLabel.centerYAnchor.constraint(equalTo: percentView.centerYAnchor),
            symbolLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor)
        ])
    }
}
