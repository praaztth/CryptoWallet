//
//  CryptoListPresenter.swift
//  CryptoWallet
//
//  Created by катенька on 22.05.2025.
//

import Foundation

protocol CryptoListPresentationProcessable: AnyObject {
    func presentSuccess(responce: CryptoListModel.Currencies.Responce)
    func presentError(responce: CryptoListModel.Currencies.Responce)
    func presentCurrencyImage(responce: CryptoListModel.ImageFetching.Responce)
    func presentLoginRequired()
}

class CryptoListPresenter: CryptoListPresentationProcessable {
    weak var viewController: CryptoListDisplayProcessable?
    
    var viewModel: CryptoListModel.Currencies.ViewModel?
    
    init(viewController: CryptoListDisplayProcessable? = nil) {
        self.viewController = viewController
    }
    
    func presentSuccess(responce: CryptoListModel.Currencies.Responce) {
        guard let currencies = responce.metrics else { return }
        let cellViewModels = currencies.map { currency in
            let id = currency.data.id
            let name = currency.data.name
            let symbol = currency.data.symbol
            
            let priceDouble = currency.data.market_data.price_usd
            let price = formatPrice(price: priceDouble, fractionDigits: 2) ?? "???"
            
            let percentChangeDouble = currency.data.market_data.percent_change_usd_last_24_hours
            let percentChange = formatPercentChange(percentChange: percentChangeDouble)
            
            var iconName = ""
            var iconColor: PercentColor?
            if percentChangeDouble > 0 {
                iconName = "chevron.up"
                iconColor = .green
            } else {
                iconName = "chevron.down"
                iconColor = .red
            }
            
            let marketcap = formatPrice(price: currency.data.marketcap.current_marketcap_usd, fractionDigits: 0) ?? "???"
            let circulatingSupply = formatCirculationSupply(circulationSupply: currency.data.supply.circulating, symbol: symbol)
            
            return CryptoListModel.Currencies.CellViewModel(id: id, name: name, symbol: symbol, price: price, iconName: iconName, iconColor: iconColor ?? .green, percentChange: percentChange, marketcap: marketcap, circulatingSupply: circulatingSupply)
        }
        
        let viewModel = CryptoListModel.Currencies.ViewModel(cellViewModels: cellViewModels)
        viewController?.displayCurrencies(viewModel: viewModel)
    }
    
    func presentError(responce: CryptoListModel.Currencies.Responce) {
        
    }
    
    func presentLoginRequired() {
        viewController?.displayLoginRequired()
    }
    
    func presentCurrencyImage(responce: CryptoListModel.ImageFetching.Responce) {
        let viewModel = CryptoListModel.ImageFetching.ViewModel(data: responce.data, indexPath: IndexPath(row: responce.index, section: 0))
        viewController?.displayCurrencyImage(viewModel: viewModel)
    }
    
    func formatPrice(price: Double, fractionDigits: Int) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = fractionDigits
        formatter.minimumFractionDigits = fractionDigits
        formatter.locale = Locale(identifier: "en_US")
        
        let formattedString = formatter.string(from: NSNumber(value: price))
        return formattedString
    }
    
    func formatPercentChange(percentChange: Double) -> String {
        let formattedString = String(format: "%.1f%%", percentChange)
        return formattedString
    }
    
    func formatCirculationSupply(circulationSupply: Double, symbol: String) -> String {
        return "\(circulationSupply.description) \(symbol)"
    }
}
