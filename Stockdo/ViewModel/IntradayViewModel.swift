//
//  IntradayViewModel.swift
//  Stockdo
//
//  Created by Dayton on 25/02/21.
//

import UIKit

struct IntradayViewModel {
    let intraday: Intraday
    
    private let displayFormatter = DateFormatter().with {
        $0.dateFormat = "MMM dd HH:mm:ss"
        $0.locale = Locale(identifier: "en_US_POSIX")
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
    
    var openColor:UIColor {
        return UIColor.yellow
    }
    var dateColor:UIColor {
        return UIColor.white
    }
    
    var lowColor:UIColor {
        if intraday.open > intraday.low {
            return UIColor.red
        } else {
            return UIColor.yellow
        }
    }

    var highColor:UIColor {
        if intraday.open < intraday.high {
            return UIColor.green
        } else {
            return UIColor.yellow
        }
    }
}
