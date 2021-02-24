//
//  SettingConfiguration.swift
//  Stockdo
//
//  Created by Dayton on 24/02/21.
//

protocol SettingConfiguration: class {
   
    func goToIntervalPickerView()
    func goToOutputPickerView()
    func saveIntoKeyChain(_ value:String)
    func saveToUserDefault(value:String, key: String)
}
