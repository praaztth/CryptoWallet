//
//  CryptoInfoViewController.swift
//  CryptoWallet
//
//  Created by катенька on 22.05.2025.
//

import Foundation
import UIKit

protocol CryptoInfoBackButtonProtocol {
    func backButtonTapped()
}

class CryptoInfoViewController: UIViewController {
    let cryptoInfoView = CryptoInfoView()
    
    var viewModel: CryptoListModel.ViewModel?
    
    var router: CryptoInfoRoutingProcessable?
    var interactor: CryptoInfoBusinessProcessable?
    
    init(configurator: CryptoInfoConfigurator, viewModel: CryptoListModel.CellViewModel) {
        super.init(nibName: nil, bundle: nil)
        configurator.configure(viewController: self)
        cryptoInfoView.configure(with: viewModel, delegate: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = cryptoInfoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension CryptoInfoViewController: CryptoInfoBackButtonProtocol {
    func backButtonTapped() {
        router?.routeBackToCryptoList()
    }
}
