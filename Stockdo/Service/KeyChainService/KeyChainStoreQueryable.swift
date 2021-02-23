//
//  KeyChainStoreQueryable.swift
//  Stockdo
//
//  Created by Dayton on 24/02/21.
//

import Foundation

 protocol KeyChainStoreQueryable {
  var query: [String: Any] { get }
}

 struct GenericPasswordQueryable {
 private let service: String
 private let accessGroup: String?
  
  init(service: String, accessGroup: String? = nil) {
    self.service = service
    self.accessGroup = accessGroup
  }
}

extension GenericPasswordQueryable: KeyChainStoreQueryable {
    var query: [String: Any] {
    var query: [String: Any] = [:]
    query[String(kSecClass)] = kSecClassGenericPassword
    query[String(kSecAttrService)] = service
    // Access group if target environment is not simulator
    #if !targetEnvironment(simulator)
    if let accessGroup = accessGroup {
      query[String(kSecAttrAccessGroup)] = accessGroup
    }
    #endif
    return query
  }
}


