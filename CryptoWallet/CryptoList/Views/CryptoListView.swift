//
//  CryptoListView.swift
//  CryptoWallet
//
//  Created by катенька on 22.05.2025.
//

import Foundation
import UIKit

class CryptoListView: UIView {
    let headerView = CryptoListHeaderView()
    let tableHeaderView = CryptoListTableHeaderView()
    
    let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.hidesWhenStopped = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "illustration_other"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGroupedBackground
        tableView.layer.cornerRadius = 40
        tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tableView.layer.masksToBounds = true
        tableView.separatorStyle = .none
        tableView.register(CryptoListTableViewCell.self, forCellReuseIdentifier: "CryptoListTableViewCell")
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        activateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = .primaryBackground
        addSubview(activityIndicator)
        addSubview(imageView)
        addSubview(headerView)
        addSubview(tableView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        tableHeaderView.frame.size.height = 70
        tableView.tableHeaderView = tableHeaderView
        
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 101),
            imageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 189),
            imageView.heightAnchor.constraint(equalToConstant: 242),
            imageView.widthAnchor.constraint(equalToConstant: 242),
            
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            headerView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 298),
            
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -40),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
        ])
    }
    
    func setNeededDelegates(tableDatasource: UITableViewDataSource, tableDelegate: UITableViewDelegate, buttonDelegate: CryptoListHeaderButtonProtocol) {
        tableView.dataSource = tableDatasource
        tableView.delegate = tableDelegate
        tableHeaderView.delegate = buttonDelegate
        headerView.delegate = buttonDelegate
    }
    
    func updateCurrencies() {
        tableView.reloadData()
    }
    
    func setCurrencyImage(for indexPath: IndexPath, image: UIImage) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CryptoListTableViewCell else {
            return
        }
        
        cell.setImage(image: image)
    }
    
    func startLoading() {
        activityIndicator.startAnimating()
        tableView.isHidden = true
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
        tableView.isHidden = false
    }
    
    func clearSortingSelection() {
        tableHeaderView.clearButtonMenuSelection()
    }
}
