//
//  KeyChainStore.swift
//  Stockdo
//
//  Created by Dayton on 24/02/21.
//

import Foundation
import Security

 struct KeyChainStore {
  private let keyChainStoreQueryable: KeyChainStoreQueryable
    
    static let APIServices = KeyChainStore(keyChainStoreQueryable: GenericPasswordQueryable(service: AppData.services))
    
   init(keyChainStoreQueryable: KeyChainStoreQueryable) {
    self.keyChainStoreQueryable = keyChainStoreQueryable
  }
  
    func setValue(_ value: String, for userAccount: String) throws {
    // 1
    guard let encodedPassword = value.data(using: .utf8) else {
      throw KeyChainStoreError.string2DataConversionError
    }

    // 2
    var query = keyChainStoreQueryable.query
    query[String(kSecAttrAccount)] = userAccount

    // 3
    var status = SecItemCopyMatching(query as CFDictionary, nil)
    switch status {
    // 4
    case errSecSuccess:
      var attributesToUpdate: [String: Any] = [:]
      attributesToUpdate[String(kSecValueData)] = encodedPassword
      
      status = SecItemUpdate(query as CFDictionary,
                             attributesToUpdate as CFDictionary)
      if status != errSecSuccess {
        throw error(from: status)
      }
    // 5
    case errSecItemNotFound:
      query[String(kSecValueData)] = encodedPassword
      
      status = SecItemAdd(query as CFDictionary, nil)
      if status != errSecSuccess {
        throw error(from: status)
      }
    default:
      throw error(from: status)
    }

  }
  
   func getValue(for userAccount: String) throws -> String? {
    // 1
    var query = keyChainStoreQueryable.query
    query[String(kSecMatchLimit)] = kSecMatchLimitOne
    query[String(kSecReturnAttributes)] = kCFBooleanTrue
    query[String(kSecReturnData)] = kCFBooleanTrue
    query[String(kSecAttrAccount)] = userAccount

    // 2
    var queryResult: AnyObject?
    let status = withUnsafeMutablePointer(to: &queryResult) {
      SecItemCopyMatching(query as CFDictionary, $0)
    }

    switch status {
    // 3
    case errSecSuccess:
      guard
        let queriedItem = queryResult as? [String: Any],
        let passwordData = queriedItem[String(kSecValueData)] as? Data,
        let password = String(data: passwordData, encoding: .utf8)
        else {
          throw KeyChainStoreError.data2StringConversionError
      }
      return password
    // 4
    case errSecItemNotFound:
      return nil
    default:
      throw error(from: status)
    }

  }
  
   func removeValue(for userAccount: String) throws {
    var query = keyChainStoreQueryable.query
    query[String(kSecAttrAccount)] = userAccount

    let status = SecItemDelete(query as CFDictionary)
    guard status == errSecSuccess || status == errSecItemNotFound else {
      throw error(from: status)
    }

  }
  
   func removeAllValues() throws {
    let query = keyChainStoreQueryable.query
      
    let status = SecItemDelete(query as CFDictionary)
    guard status == errSecSuccess || status == errSecItemNotFound else {
      throw error(from: status)
    }

  }
  
   func error(from status: OSStatus) -> KeyChainStoreError {
    let message = SecCopyErrorMessageString(status, nil) as String? ?? NSLocalizedString("Unhandled Error", comment: "")
    return KeyChainStoreError.unhandledError(message: message)
  }
}

