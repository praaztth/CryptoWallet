//
//  LoginRouter.swift
//  CryptoWallet
//
//  Created by катенька on 22.05.2025.
//

import Foundation
import UIKit

protocol LoginRoutingProcessable: AnyObject {
    func routeToCryptoList()
}

class LoginRouter: LoginRoutingProcessable {
    weak var viewController: LoginViewController?
    
    init(viewController: LoginViewController?) {
        self.viewController = viewController
    }
    
    func routeToCryptoList() {
        let tabBarController = MainTabBarController()
        viewController?.view.window?.rootViewController = tabBarController
    }
}
