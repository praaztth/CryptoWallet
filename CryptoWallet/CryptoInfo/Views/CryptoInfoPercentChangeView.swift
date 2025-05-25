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
            UIColor.green
        case .red:
            UIColor.red
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
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func configure(percent: String, iconName: String, iconColor: UIColor) {
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 10)
        imageView.image = UIImage(systemName: iconName, withConfiguration: symbolConfig)
        imageView.tintColor = iconColor
        label.text = percent
        
        layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
