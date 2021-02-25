//
//  DailyAdjustedViewModel.swift
//  Stockdo
//
//  Created by Dayton on 25/02/21.
//

import UIKit

struct DailyAdjustedViewModel {
    let dailyAdjusted: DailyAdjusted
    
    private let displayFormatter = DateFormatter().with {
        $0.dateFormat = "MMM dd HH:mm:ss"
        $0.locale = Locale(identifier: "en_US_POSIX")
    }
}

