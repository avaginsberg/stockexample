//
//  DailyAdjustedViewModel.swift
//  Stockdo
//
//  Created by Dayton on 25/02/21.
//

import UIKit

struct DailyAdjustedViewModel {
    let firstSymbol: DailyAdjusted?
    let secondSymbol: DailyAdjusted?
    let thirdSymbol: DailyAdjusted?
    
    private let displayFormatter = DateFormatter().with {
        $0.dateFormat = "MMM dd HH:mm:ss"
        $0.locale = Locale(identifier: "en_US_POSIX")
    }
    
    init(firstSymbol:DailyAdjusted? = nil, secondSymbol:DailyAdjusted? = nil, thirdSymbol:DailyAdjusted? = nil) {
        self.firstSymbol = firstSymbol
        self.secondSymbol = secondSymbol
        self.thirdSymbol = thirdSymbol
    }
}

