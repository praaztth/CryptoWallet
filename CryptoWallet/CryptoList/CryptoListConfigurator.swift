//
//  CryptoListConfigurator.swift
//  CryptoWallet
//
//  Created by катенька on 22.05.2025.
//

import Foundation

class CryptoListConfigurator {
    func configure(viewController: CryptoListViewController) {
        let router = CryptoListRouter(viewController: viewController)
        let presenter = CryptoListPresenter(viewController: viewController)
        let interactor = CryptoListInteractor(presenter: presenter)
        
        viewController.router = router
        viewController.interactor = interactor
    }
}
