//
//  IntradayStock.swift
//  Stockdo
//
//  Created by Dayton on 24/02/21.
//
struct IntradayStock: Decodable {
    let metaData: IntraMetaData
    let intradayTimeSeries: [String: IntradayTimeSeries]

    init(from decoder: Decoder) throws {
        var timeSeries = [String: IntradayTimeSeries]()
        var intraMetaData: IntraMetaData?
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        for key in container.allKeys {
            if key.stringValue != "Meta Data" {
                let intradaySeries = try container.decode([String: IntradayTimeSeries].self, forKey: CodingKeys(stringValue: key.stringValue)!)
                timeSeries.merge(dict: intradaySeries)
            } else {
                let metaData = try container.decode(IntraMetaData.self, forKey: CodingKeys(stringValue: key.stringValue)!)
                intraMetaData = metaData
            }
        }
        guard let metaData = intraMetaData else {fatalError("Meta Data was nil")}
        
        self.intradayTimeSeries = timeSeries
        self.metaData = metaData
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

//MARK: - Dynamic Coding Key Initializer
struct CodingKeys: CodingKey {
    var stringValue: String
    
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    var intValue: Int?
    init?(intValue: Int) {
        return nil
    }
}
