//
//  AppData.swift
//  Stockdo
//
//  Created by Dayton on 24/02/21.
//

import Foundation

struct AppData {
    
    // UserDefaults Property Wrapper
    
    @Defaults(key: "intervalValue", defaultValue: "5min")
    static var intervalValue: String
    
    @Defaults(key: "outputSizeValue", defaultValue: "compact")
    static var outputSizeValue: String
    
    @Defaults(key: "services", defaultValue: "APIService")
    static var services: String
    
    @Defaults(key: "accounts", defaultValue: "DefAccount")
    static var accounts: String
    
}


