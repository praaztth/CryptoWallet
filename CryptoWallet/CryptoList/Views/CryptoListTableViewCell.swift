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
    let percentChangeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        activateContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(name: String, price: String, percentChange: String) {
        nameLabel.text = name
        priceLabel.text = price
        percentChangeLabel.text = percentChange
    }
    
    func setupViews() {
        backgroundColor = .systemGroupedBackground
        
        nameLabel.applyTableViewCellTitle()
        priceLabel.applyTableViewCellTitle()
        percentChangeLabel.applyTableViewCellSubtitle()
        
        [nameLabel, priceLabel, percentChangeLabel].forEach { view in
            addSubview(view)
        }
    }
    
    func activateContraints() {
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            priceLabel.topAnchor.constraint(equalTo: topAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            percentChangeLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 3),
            percentChangeLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
