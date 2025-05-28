//
//  MainTabBarController.swift
//  CryptoWallet
//
//  Created by катенька on 23.05.2025.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
        setupTabs()
    }
    
    func setupTabs() {
        let configurator = CryptoListConfigurator()
        let cryptoListViewController = CryptoListViewController(configurator: configurator)
        let nvc = UINavigationController(rootViewController: cryptoListViewController)
        
        let stub1 = ViewControllerStub()
        let stub2 = ViewControllerStub()
        let stub3 = ViewControllerStub()
        let stub4 = ViewControllerStub()
        
        nvc.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house"), tag: 0)
        stub1.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "chart.bar"), tag: 1)
        stub2.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "creditcard"), tag: 2)
        stub3.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "doc.plaintext"), tag: 3)
        stub4.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person"), tag: 4)
        
        viewControllers = [nvc, stub1, stub2, stub3, stub4]
    }
}

class ViewControllerStub: UIViewController {
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        label.textColor = .gray
        label.text = "Coming soon..."
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(label)
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
