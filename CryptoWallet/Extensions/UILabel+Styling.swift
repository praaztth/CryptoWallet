//
//  UILabel+Styling.swift
//  CryptoWallet
//
//  Created by катенька on 23.05.2025.
//

import Foundation
import UIKit

extension UILabel {
    func applyTableViewCellTitle() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.font = .systemFont(ofSize: 18)
        self.textColor = .black
    }
    
    func applyTableViewCellSubtitle() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.font = .systemFont(ofSize: 14)
        self.textColor = .gray
    }
    
    func applyValueLabel() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.font = .systemFont(ofSize: 14, weight: .bold)
        self.textColor = .black
    }
}
