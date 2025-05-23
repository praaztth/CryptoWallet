//
//  CryptoListModel.swift
//  CryptoWallet
//
//  Created by катенька on 23.05.2025.
//

import Foundation

struct CryptoListModel {
    struct Responce {
        let isSuccess: Bool
        let metricts: [Metrics]?
        let error: NetworkServiceError?
        
        init(isSuccess: Bool, metricts: [Metrics]? = nil, error: NetworkServiceError? = nil) {
            self.isSuccess = isSuccess
            self.metricts = metricts
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
        let percentChange: String
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
    let roi_data: RoiData
}

struct MarketData: Decodable {
    let price_usd: Double
    let percent_change_usd_last_24_hours: Double
}

struct RoiData: Decodable {
    let percent_change_last_1_week: Double?
    let percent_change_last_1_year: Double?
}
