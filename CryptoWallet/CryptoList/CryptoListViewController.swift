//
//  CryptoListViewController.swift
//  CryptoWallet
//
//  Created by катенька on 22.05.2025.
//

import Foundation
import UIKit

protocol CryptoListDisplayProcessable: AnyObject {
    
}

class CryptoListViewController: UIViewController, CryptoListDisplayProcessable {
    let cryptoListView = CryptoListView()
    
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
}
