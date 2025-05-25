//
//  CryptoInfoConfigurator.swift
//  CryptoWallet
//
//  Created by катенька on 22.05.2025.
//

import Foundation

class CryptoInfoConfigurator {
    func configure(viewController: CryptoInfoViewController) {
        let router = CryptoInfoRouter(viewController: viewController)
        let presenter = CryptoInfoPresenter(viewController: viewController)
        let interactor = CryptoInfoInteractor(presenter: presenter)
        
        viewController.router = router
        viewController.interactor = interactor
    }
}
