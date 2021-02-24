//
//  DailyStock.swift
//  Stockdo
//
//  Created by Dayton on 24/02/21.
//

struct DailyStock: Codable {
    let metaData: DailyMetaData
    let dailyTimeSeries: [String: DailyTimeSeries]

    enum CodingKeys: String, CodingKey {
        case metaData = "Meta Data"
        case dailyTimeSeries = "Time Series (Daily)"
    }
}

// MARK: - MetaData
struct DailyMetaData: Codable {
    let information, symbol, lastRefreshed: String
    let outputSize, timeZone: String

    enum CodingKeys: String, CodingKey {
        case information = "1. Information"
        case symbol = "2. Symbol"
        case lastRefreshed = "3. Last Refreshed"
        case outputSize = "4. Output Size"
        case timeZone = "5. Time Zone"
    }
}

// MARK: - TimeSeries5Min
struct DailyTimeSeries: Codable {
    let open, low: String

    enum CodingKeys: String, CodingKey {
        case open = "1. open"
        case low = "3. low"
        
    }
}

