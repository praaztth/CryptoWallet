//
//  CryptoListModel.swift
//  CryptoWallet
//
//  Created by катенька on 23.05.2025.
//

import Foundation

struct CryptoListModel {
    struct Request {
        let isSortByAscending: Bool
        let cells: [CryptoListModel.CellViewModel]
    }
    
    struct Responce {
        let metrics: [Metrics]?
        let error: NetworkServiceError?
        
        init(metrics: [Metrics]? = nil, error: NetworkServiceError? = nil) {
            self.metrics = metrics
            self.error = error
        }
    }
    
    struct ViewModel {
        let cellViewModels: [CellViewModel]
    }
    
    struct CellViewModel {
        let name: String
        let symbol: String
        let price: String
        let iconName: String
        let iconColor: PercentColor
        let percentChange: String
        let marketcap: String
        let circulatingSupply: String
    }
}

struct Metrics: Decodable {
    let data: DataObject
}

struct Status: Decodable {
    let elapsed: Int
}

struct DataObject: Decodable {
    let symbol: String
    let name: String
    let market_data: MarketData
    let marketcap: MarketCapitalization
    let supply: CirculatingSupply
    let roi_data: RoiData
}

struct MarketData: Decodable {
    let price_usd: Double
    let percent_change_usd_last_24_hours: Double
}

struct MarketCapitalization: Decodable {
    let current_marketcap_usd: Double
}

struct CirculatingSupply: Decodable {
    let circulating: Double
}

struct RoiData: Decodable {
    let percent_change_last_1_week: Double?
    let percent_change_last_1_year: Double?
}
