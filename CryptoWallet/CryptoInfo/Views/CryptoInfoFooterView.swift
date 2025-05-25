//
//  CryptoInfoFooterView.swift
//  CryptoWallet
//
//  Created by катенька on 25.05.2025.
//

import Foundation
import UIKit

class CryptoInfoFooterView: UIView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Market Statistic"
        return label
    }()
    
    let marketCapitalizationLabel: UILabel = {
        let label = UILabel()
        label.applyTableViewCellSubtitle()
        label.text = "Market capitalization"
        return label
    }()
    
    let circulatingSuplyLabel: UILabel = {
        let label = UILabel()
        label.applyTableViewCellSubtitle()
        label.text = "Circulating Suply"
        return label
    }()
    
    let marketCapitalizationValueLabel: UILabel = {
        let label = UILabel()
        label.applyValueLabel()
        return label
    }()
    
    let circulatingSuplyValueLabel: UILabel = {
        let label = UILabel()
        label.applyValueLabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemGroupedBackground
        layer.cornerRadius = 40
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        layer.masksToBounds = true
        setupViews()
        activateConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(marketCapitalization: String, circulatingSuply: String) {
        marketCapitalizationValueLabel.text = marketCapitalization
        circulatingSuplyValueLabel.text = circulatingSuply
    }
    
    func setupViews() {
        [
            titleLabel,
            marketCapitalizationLabel,
            circulatingSuplyLabel,
            marketCapitalizationValueLabel,
            circulatingSuplyValueLabel
        ].forEach { addSubview($0) }
    }
    
    func activateConstrains() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            marketCapitalizationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            marketCapitalizationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            circulatingSuplyLabel.topAnchor.constraint(equalTo: marketCapitalizationLabel.bottomAnchor, constant: 15),
            circulatingSuplyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            marketCapitalizationValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            marketCapitalizationValueLabel.centerYAnchor.constraint(equalTo: marketCapitalizationLabel.centerYAnchor),
            circulatingSuplyValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            circulatingSuplyValueLabel.centerYAnchor.constraint(equalTo: circulatingSuplyLabel.centerYAnchor)
        ])
    }
}
