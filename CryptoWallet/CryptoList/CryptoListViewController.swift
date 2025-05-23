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
    func displayLoginRequired()
}

protocol CryptoListHeaderButtonProtocol: AnyObject {
    func updateButtonTapped()
    func logoutButtonTapped()
    func sortByAscendingButtonTapped()
    func sortByDescendingButtonTapped()
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
        
        cryptoListView.setNeededDelegates(datasource: self, delegate: self)
        
        let rightButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle.fill"), style: .plain, target: self, action: nil)
        rightButton.tintColor = .black
        navigationItem.rightBarButtonItem = rightButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        loadData()
    }
    
    func loadData() {
        cryptoListView.startLoading()
        interactor?.loadData()
    }
    
    func displayCurrencies(viewModel: CryptoListModel.ViewModel) {
        currencies = viewModel.cellViewModels
        cryptoListView.updateCurrencies()
        cryptoListView.stopLoading()
    }
    
    func displayLoginRequired() {
        router?.routeToLogin()
    }
}

extension CryptoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoListTableViewCell", for: indexPath) as? CryptoListTableViewCell else {
            return UITableViewCell(frame: .zero)
        }
        
        let item = currencies[indexPath.row]
        let name = item.name
        let price = item.price
        let percentChange = item.percentChange
        cell.configure(name: name, price: price, percentChange: percentChange)
        
        return cell
    }
}

extension CryptoListViewController: CryptoListHeaderButtonProtocol {
    func updateButtonTapped() {
        loadData()
        cryptoListView.clearSortingSelection()
    }
    
    func logoutButtonTapped() {
        interactor?.logout()
    }
    
    func sortByAscendingButtonTapped() {
        let request = CryptoListModel.Request(isSortByAscending: true, cells: currencies)
        interactor?.sort(request: request)
    }
    
    func sortByDescendingButtonTapped() {
        let request = CryptoListModel.Request(isSortByAscending: false, cells: currencies)
        interactor?.sort(request: request)
    }
}
