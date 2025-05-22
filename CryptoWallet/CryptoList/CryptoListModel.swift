//
//  CryptoListModel.swift
//  CryptoWallet
//
//  Created by катенька on 23.05.2025.
//

import Foundation

struct CryptoListModel {
    struct Responce {
        let metricts: Metrics
    }
}

struct Metrics: Decodable {
//    let status: Status
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
