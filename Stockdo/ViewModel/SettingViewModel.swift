//
//  SettingViewModel.swift
//  Stockdo
//
//  Created by Dayton on 24/02/21.
//

import Foundation


enum SettingViewModel:Int, CaseIterable {
   
    case apiKey
    case interval
    case outputSize
    
    var description:String {
        switch self {
        case .apiKey:
            return "ApiKey"
        case .interval:
            return "Interval"
        case .outputSize:
            return "Output Size"
        }
    }
    
    var iconImages: String {
        switch self {
        case .apiKey:
            return "person.circle"
        case .interval:
            return "gear"
        case .outputSize:
            return ""
        }
    }
    
    var sectionPosition: Int {
        switch self {
        case .apiKey:
            return 0
        case .interval:
            return 1
        case .outputSize:
            return 1
        }
    }
    
}

