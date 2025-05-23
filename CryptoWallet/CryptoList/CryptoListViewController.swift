//
//  CryptoListViewController.swift
//  CryptoWallet
//
//  Created by катенька on 22.05.2025.
//

import Foundation
import UIKit

protocol CryptoListDisplayProcessable: AnyObject {
    func displayCurrencies(viewModel: CryptoListModel.ViewModel)
}

class CryptoListViewController: UIViewController, CryptoListDisplayProcessable {
    let cryptoListView = CryptoListView()
    
    var currencies: [CryptoListModel.CellViewModel] = []
    
    var router: CryptoListRoutingProcessable?
    var interactor: CryptoListBusinessProcessable?
    
    init(configurator: CryptoListConfigurator) {
        super.init(nibName: nil, bundle: nil)
        configurator.configure(viewController: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = cryptoListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cryptoListView.setTableDelegates(datasource: self)
        
        title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let rightButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle.fill"), style: .plain, target: self, action: nil)
        rightButton.tintColor = .black
        navigationItem.rightBarButtonItem = rightButton
    }
    
    override func viewDidAppear(_ animated: Bool) {
        cryptoListView.startLoading()
        interactor?.loadData()
    }
    
    func displayCurrencies(viewModel: CryptoListModel.ViewModel) {
        currencies = viewModel.cellViewModels
        cryptoListView.updateCurrencies()
        cryptoListView.stopLoading()
    }
}

extension CryptoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "simpleCell", for: indexPath)
        cell.textLabel?.text = currencies[indexPath.row].name
        
        return cell
    }
    
    
}
