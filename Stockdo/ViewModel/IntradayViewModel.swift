//
//  IntradayViewModel.swift
//  Stockdo
//
//  Created by Dayton on 25/02/21.
//

import Foundation

struct IntradayViewModel {
    let intraday: Intraday
    
    private let displayFormatter = DateFormatter().with {
        $0.dateFormat = "MMM dd HH:mm:ss"
        $0.locale = Locale(identifier: "en_US_POSIX")
    }
    
    init(intraday: Intraday) {
        self.intraday = intraday
    }
    
    var getDisplayedDate:String {
         return displayFormatter.string(from: intraday.date)
    }
    
    var formattedOpen:String {
        return String(format: "%.2f", intraday.open)
    }
    
    var formattedLow:String {
        return String(format: "%.2f", intraday.low)
    }
    
    var formattedHigh:String {
        return String(format: "%.2f", intraday.high)
    }
    
}
