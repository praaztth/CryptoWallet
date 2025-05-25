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
    let percentView = CryptoInfoPercentChangeView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        activateContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(name: String, price: String, percentChange: String, iconName: String, iconColor: UIColor) {
        nameLabel.text = name
        priceLabel.text = price
        percentView.configure(percent: percentChange, iconName: iconName, iconColor: iconColor)
    }
    
    func setupViews() {
        backgroundColor = .systemGroupedBackground
        
        nameLabel.applyTableViewCellTitle()
        priceLabel.applyTableViewCellTitle()
        
        percentView.translatesAutoresizingMaskIntoConstraints = false
        
        [nameLabel, priceLabel, percentView].forEach { view in
            addSubview(view)
        }
    }
    
    func activateContraints() {
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            priceLabel.topAnchor.constraint(equalTo: topAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            percentView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 3),
            percentView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
