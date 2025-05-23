//
//  CryptoListTableHeaderView.swift
//  CryptoWallet
//
//  Created by катенька on 23.05.2025.
//

import Foundation
import UIKit

class CryptoListTableHeaderView: UIView {
    weak var delegate: CryptoListHeaderButtonProtocol?
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.text = "Trending"
        return label
    }()
    
    let button: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "line.3.horizontal.decrease")
        config.contentInsets = .zero
        config.baseForegroundColor = .black
        
        let button = UIButton(configuration: config)
        button.showsMenuAsPrimaryAction = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        button.menu = buildMenu()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildMenu() -> UIMenu {
        let descendingItem = UIAction(title: "По убыванию цены", state: .on) { [weak self] _ in
            self?.delegate?.sortByDescendingButtonTapped()
        }
        
        let ascendingItem = UIAction(title: "По возрастанию цены") { [weak self] _ in
            self?.delegate?.sortByAscendingButtonTapped()
        }
        
        let menu = UIMenu(options: .singleSelection, children: [descendingItem, ascendingItem])
        return menu
    }
    
    func setupViews() {
        backgroundColor = .systemGroupedBackground
        
        addSubview(label)
        addSubview(button)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            button.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func clearButtonMenuSelection() {
        button.menu = buildMenu()
    }
}
