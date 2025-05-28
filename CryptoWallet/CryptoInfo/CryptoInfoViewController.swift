//
//  CryptoInfoViewController.swift
//  CryptoWallet
//
//  Created by катенька on 22.05.2025.
//

import Foundation
import UIKit

protocol CryptoInfoDisplayProcessable: AnyObject {
    func displayLoginRequired()
}

protocol CryptoInfoButtonsProtocol {
    func backButtonTapped()
    func logoutButtonTapped()
}

class CryptoInfoViewController: UIViewController {
    let cryptoInfoView = CryptoInfoView()
    
    var viewModel: CryptoListModel.Currencies.CellViewModel
    
    var router: CryptoInfoRoutingProcessable?
    var interactor: CryptoInfoBusinessProcessable?
    
    init(configurator: CryptoInfoConfigurator, viewModel: CryptoListModel.Currencies.CellViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        configurator.configure(viewController: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        cryptoInfoView.frame = UIScreen.main.bounds
        view = cryptoInfoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cryptoInfoView.configure(with: self.viewModel, delegate: self)
    }
}

extension CryptoInfoViewController: CryptoInfoDisplayProcessable {
    func displayLoginRequired() {
        router?.routeToLogin()
    }
}

extension CryptoInfoViewController: CryptoInfoButtonsProtocol {
    func backButtonTapped() {
        router?.routeBackToCryptoList()
    }
    
    func logoutButtonTapped() {
        interactor?.logout()
    }
}
