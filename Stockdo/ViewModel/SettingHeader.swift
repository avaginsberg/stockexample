//
//  SettingHeader.swift
//  Stockdo
//
//  Created by Dayton on 24/02/21.
//

import Foundation


enum SettingHeader:Int, CaseIterable {
   
    case api
    case parameter
    
    var title:String {
        switch self {
        case .api:
            return "API Configuration"
        case .parameter:
            return "Parameter"
       
        }
    }
    
    var sectionRow:Int {
        switch self {
        case .api:
            return 1
        case .parameter:
            return 2
        }
    }
    
}


