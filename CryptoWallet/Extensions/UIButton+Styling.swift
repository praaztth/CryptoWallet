//
//  UIButton.swift
//  CryptoWallet
//
//  Created by катенька on 25.05.2025.
//

import Foundation
import UIKit

extension UIButton.Configuration {
    public static func round(imageName: String) -> UIButton.Configuration {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = UIColor(white: 1, alpha: 0.8)
        config.baseBackgroundColor = .black
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
        let colorConfig = UIImage.SymbolConfiguration(paletteColors: [.black, .init(white: 1, alpha: 0.8)])
        config.image = UIImage(systemName: imageName, withConfiguration: symbolConfig.applying(colorConfig))
        config.contentInsets = .zero
        
        return config
    }
}
