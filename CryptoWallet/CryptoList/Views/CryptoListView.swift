//
//  CryptoListView.swift
//  CryptoWallet
//
//  Created by катенька on 22.05.2025.
//

import Foundation
import UIKit

class CryptoListView: UIView {
    var currencies: [CryptoListModel.CellViewModel] = []
    
    let headerView = CryptoListHeaderView()
    let tableHeaderView = CryptoListTableHeaderView()
    
    let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.hidesWhenStopped = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGroupedBackground
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "simpleCell")
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
        backgroundColor = .systemPink
        addSubview(activityIndicator)
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
            
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            headerView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 258),
            
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
        ])
    }
    
    func setNeededDelegates(datasource: UITableViewDataSource, delegate: CryptoListHeaderButtonProtocol) {
        tableView.dataSource = datasource
        headerView.delegate = delegate
    }
    
    func updateCurrencies() {
        tableView.reloadData()
    }
    
    func startLoading() {
        activityIndicator.startAnimating()
        tableView.isHidden = true
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
        tableView.isHidden = false
    }
}
