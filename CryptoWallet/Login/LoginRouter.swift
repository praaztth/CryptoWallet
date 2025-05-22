//
//  LoginRouter.swift
//  CryptoWallet
//
//  Created by катенька on 22.05.2025.
//

import Foundation

protocol RoutingProcessable: AnyObject {
    func routeToCryptoList()
}

class LoginRouter: RoutingProcessable {
    weak var viewController: LoginViewController?
    
    init(viewController: LoginViewController?) {
        self.viewController = viewController
    }
    
    func routeToCryptoList() {
        let vc = CryptoListViewController()
        viewController?.navigationController?.viewControllers = [vc]
    }
}
