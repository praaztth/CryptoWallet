//
//  CryptoInfoPercentChangeView.swift
//  CryptoWallet
//
//  Created by катенька on 25.05.2025.
//

import Foundation
import UIKit

enum PercentColor {
    case green
    case red
    
    var color: UIColor {
        switch self {
        case .green:
            UIColor.systemGreen
        case .red:
            UIColor.systemRed
        }
    }
}

class CryptoInfoPercentChangeView: UIView {
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        
//        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
    func configure(percent: String, iconName: String, iconColor: UIColor) {
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 10)
        imageView.image = UIImage(systemName: iconName, withConfiguration: symbolConfig)
        imageView.tintColor = iconColor
        label.text = percent
        
        layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        print()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
