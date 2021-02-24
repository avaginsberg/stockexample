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
            return "key.icloud"
        case .interval:
            return "timer"
        case .outputSize:
            return "doc.text"
        }
    }
    
    var keyboardType: Int {
        switch self {
        case .apiKey:
            return 0
        case .interval:
            return 1
        case .outputSize:
            return 2
        }
    }
    
    var keyChainValue:String? {
        let keychain = KeyChainStore(keyChainStoreQueryable: GenericPasswordQueryable(service: AppData.services))
        do {
            return try keychain.getValue(for: "123")
        } catch {
            print(error)
        }
        return nil
    }
    
    var settingValue:String? {
        switch self {
        case .apiKey:
            return keyChainValue
        case .interval:
            return AppData.intervalValue
        case .outputSize:
            return AppData.outputSizeValue
        }
    }
    
}

