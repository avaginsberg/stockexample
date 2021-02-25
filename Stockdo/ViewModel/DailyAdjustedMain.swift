//
//  DailyAdjustedMain.swift
//  Stockdo
//
//  Created by Dayton on 26/02/21.
//

import Foundation


enum DailyAdjustedMain:String, CaseIterable {
   
    case firstSymbol
    case secondSymbol
    case thirdSymbol
    
}

enum SymbolAvailability:String, CaseIterable {
    
    case zeroValueExist
    case oneValueExist
    case twoValueExist
    case threeValueExist
    
}
