//
//  IntradayStock.swift
//  Stockdo
//
//  Created by Dayton on 24/02/21.
//

struct IntradayStock: Codable {
    let metaData: IntraMetaData
    let intradayTimeSeries: [String: IntradayTimeSeries]

    enum CodingKeys: String, CodingKey {
        case metaData = "Meta Data"
        case intradayTimeSeries = "Time Series (5min)"
    }
}

// MARK: - MetaData
struct IntraMetaData: Codable {
    let information, symbol, lastRefreshed, interval: String
    let outputSize, timeZone: String

    enum CodingKeys: String, CodingKey {
        case information = "1. Information"
        case symbol = "2. Symbol"
        case lastRefreshed = "3. Last Refreshed"
        case interval = "4. Interval"
        case outputSize = "5. Output Size"
        case timeZone = "6. Time Zone"
    }
}

// MARK: - TimeSeries5Min
struct IntradayTimeSeries: Codable {
    let open, high, low: String

    enum CodingKeys: String, CodingKey {
        case open = "1. open"
        case high = "2. high"
        case low = "3. low"
        
    }
}
