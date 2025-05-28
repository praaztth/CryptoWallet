//
//  CryptoListInteractor.swift
//  CryptoWallet
//
//  Created by катенька on 22.05.2025.
//

import Foundation

protocol CryptoListBusinessProcessable: AnyObject {
    func loadData()
    func logout()
    func sort(request: CryptoListModel.SortRequest)
    func loadCurrencyImage(request: CryptoListModel.ImageFetching.Request)
}

class CryptoListInteractor: CryptoListBusinessProcessable {
    var presenter: CryptoListPresentationProcessable
    var worker: CryptoListWorkingProcessable
    
    init(presenter: CryptoListPresentationProcessable) {
        self.presenter = presenter
        self.worker = CryptoListWorker()
    }
    
    func loadData() {
        worker.fetchData { result in
            switch result {
            case .success(let results):
                let sortedResults = self.sortResults(results: results, isAscending: false)
                let responce = CryptoListModel.Currencies.Responce(metrics: sortedResults)
                self.presenter.presentSuccess(responce: responce)
            case .failure(let error):
                let responce = CryptoListModel.Currencies.Responce(error: error)
                self.presenter.presentError(responce: responce)
            }
        }
    }
    
    func loadCurrencyImage(request: CryptoListModel.ImageFetching.Request) {
        let id = request.id
        let index = request.index
        
        worker.fetchImageData(id: id) { [weak self] result in
            switch result {
            case .success(let result):
                let responce = CryptoListModel.ImageFetching.Responce(data: result, index: index)
                DispatchQueue.main.async {
                    self?.presenter.presentCurrencyImage(responce: responce)
                }
                
            case .failure(let error):
                print("ERROR: \(#function), \(error)")
                let responce = CryptoListModel.ImageFetching.Responce(data: nil, index: index)
                DispatchQueue.main.async {
                    self?.presenter.presentCurrencyImage(responce: responce)
                }
            }
        }
    }
    
    func sortResults(results: [Metrics], isAscending: Bool) -> [Metrics] {
        if isAscending {
            return results.sorted { $0.data.market_data.price_usd < $1.data.market_data.price_usd }
            
        } else {
            return results.sorted { $0.data.market_data.price_usd > $1.data.market_data.price_usd }
        }
    }
    
    func logout() {
        let authStorage = AuthStorage.shared
        authStorage.isAuthorized = false
        presenter.presentLoginRequired()
    }
    
    func sort(request: CryptoListModel.SortRequest) {
        let metrics = request.cells.map { cell in
            let price = formatStringPriceToDouble(stringPrice: cell.price) ?? 0
            let percent = formatStringPercentToDouble(stringPercent: cell.percentChange) ?? 0
            let marketcap = formatStringPriceToDouble(stringPrice: cell.marketcap) ?? 0
            let supply = Double(cell.circulatingSupply) ?? 0
            return Metrics(data:
                            DataObject(id: cell.id,
                                       symbol: cell.symbol,
                                       name: cell.name,
                                       market_data:
                                        MarketData(price_usd: price,
                                                   percent_change_usd_last_24_hours: percent),
                                       marketcap: MarketCapitalization(current_marketcap_usd: marketcap),
                                       supply: CirculatingSupply(circulating: supply),
                                       roi_data: RoiData(percent_change_last_1_week: percent,
                                                         percent_change_last_1_year: percent))
            )
        }
        
        let isAscending = request.isSortByAscending
        
        let sortedCurrencies = sortResults(results: metrics, isAscending: isAscending)
        let responce = CryptoListModel.Currencies.Responce(metrics: sortedCurrencies)
        presenter.presentSuccess(responce: responce)
    }
    
    func formatStringPriceToDouble(stringPrice: String) -> Double? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .currency
        let number = formatter.number(from: stringPrice)
        return number?.doubleValue
    }
    
    func formatStringPercentToDouble(stringPercent: String) -> Double? {
        let cleanedString = stringPercent.replacingOccurrences(of: "%", with: "")
        return Double(cleanedString)
    }
}
