//
//  String+Extension.swift
//  Stockdo
//
//  Created by Dayton on 24/02/21.
//

import UIKit

extension String {

static let numberFormatter = NumberFormatter()
var doubleValue: Double {
    String.numberFormatter.decimalSeparator = "."
    if let result =  String.numberFormatter.number(from: self) {
        return result.doubleValue
    } else {
        String.numberFormatter.decimalSeparator = ","
        if let result = String.numberFormatter.number(from: self) {
            return result.doubleValue
        }
    }
    return 0
}
}
