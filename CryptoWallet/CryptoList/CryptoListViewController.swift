//
//  CryptoListViewController.swift
//  CryptoWallet
//
//  Created by катенька on 22.05.2025.
//

import Foundation
import UIKit

protocol CryptoListDisplayProcessable: AnyObject {
    func displayCurrencies(viewModel: CryptoListModel.Currencies.ViewModel)
    func displayLoginRequired()
    func displayCurrencyImage(viewModel: CryptoListModel.ImageFetching.ViewModel)
}

protocol CryptoListHeaderButtonProtocol: AnyObject {
    func updateButtonTapped()
    func logoutButtonTapped()
    func sortByAscendingButtonTapped()
    func sortByDescendingButtonTapped()
}

class CryptoListViewController: UIViewController, CryptoListDisplayProcessable {
    let cryptoListView = CryptoListView()
    
    var viewModel: CryptoListModel.Currencies.ViewModel?
    
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
        
        cryptoListView.setNeededDelegates(tableDatasource: self, tableDelegate: self, buttonDelegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        loadData()
    }
    
    func loadData() {
        cryptoListView.startLoading()
        cryptoListView.clearSortingSelection()
        interactor?.loadData()
    }
    
    func displayCurrencies(viewModel: CryptoListModel.Currencies.ViewModel) {
        self.viewModel = viewModel
        cryptoListView.updateCurrencies()
        cryptoListView.stopLoading()
    }
    
    func displayLoginRequired() {
        router?.routeToLogin()
    }
    
    func displayCurrencyImage(viewModel: CryptoListModel.ImageFetching.ViewModel) {
        let indexPath = viewModel.indexPath
        let imageData = viewModel.data
        
        guard let imageData = imageData,
              let image = UIImage(data: imageData) else {
            let image = UIImage(systemName: "questionmark.circle")
            cryptoListView.setCurrencyImage(for: indexPath, image: image ?? UIImage())
            return
        }
        
        cryptoListView.setCurrencyImage(for: indexPath, image: image)
    }
}

extension CryptoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cellViewModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoListTableViewCell", for: indexPath) as? CryptoListTableViewCell,
              let item = viewModel?.cellViewModels[indexPath.row] else {
            return UITableViewCell(frame: .zero)
        }
        
        let id = item.id
        let name = item.name
        let symbol = item.symbol
        let price = item.price
        let percentChange = item.percentChange
        let iconName = item.iconName
        let iconColor = item.iconColor
        cell.configure(name: name, symbol: symbol, price: price, percentChange: percentChange, iconName: iconName, iconColor: iconColor.color)
        
        if !cell.isImageLoaded {
            let request = CryptoListModel.ImageFetching.Request(id: id, index: indexPath.row)
            interactor?.loadCurrencyImage(request: request)
        }
        
        return cell
    }
}

extension CryptoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let currency = viewModel?.cellViewModels[indexPath.row] ?? CryptoListModel.Currencies.CellViewModel(id: "", name: "", symbol: "", price: "", iconName: "", iconColor: .green, percentChange: "", marketcap: "", circulatingSupply: "")
        router?.routeToCryptoInfo(currency: currency)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension CryptoListViewController: CryptoListHeaderButtonProtocol {
    func updateButtonTapped() {
        loadData()
    }
    
    func logoutButtonTapped() {
        interactor?.logout()
    }
    
    func sortByAscendingButtonTapped() {
        guard let viewModel = viewModel else { return }
        let currenciesToSort = viewModel.cellViewModels
        let request = CryptoListModel.SortRequest(isSortByAscending: true, cells: currenciesToSort)
        interactor?.sort(request: request)
    }
    
    func sortByDescendingButtonTapped() {
        guard let viewModel = viewModel else { return }
        let currenciesToSort = viewModel.cellViewModels
        let request = CryptoListModel.SortRequest(isSortByAscending: false, cells: currenciesToSort)
        interactor?.sort(request: request)
    }
}
