//
//  StockdoTests.swift
//  StockdoTests
//
//  Created by Dayton on 23/02/21.
//

import XCTest
@testable import Stockdo

class StockdoTests: XCTestCase {

    var keyChainStoreWithGenericPwd: KeyChainStore!

    override func setUp() {
      super.setUp()
      
      let genericPwdQueryable = GenericPasswordQueryable(service: "someService")
        keyChainStoreWithGenericPwd = KeyChainStore(keyChainStoreQueryable: genericPwdQueryable)
      
    }

    override func tearDown() {
      try? keyChainStoreWithGenericPwd.removeAllValues()
      
      super.tearDown()
    }

    // 1
    func testSaveGenericPassword() {
      do {
        try keyChainStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
      } catch (let e) {
        XCTFail("Saving generic password failed with \(e.localizedDescription).")
      }
    }

    // 2
    func testReadGenericPassword() {
      do {
        try keyChainStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
        let password = try keyChainStoreWithGenericPwd.getValue(for: "genericPassword")
        XCTAssertEqual("pwd_1234", password)
      } catch (let e) {
        XCTFail("Reading generic password failed with \(e.localizedDescription).")
      }
    }

    // 3
    func testUpdateGenericPassword() {
      do {
        try keyChainStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
        try keyChainStoreWithGenericPwd.setValue("pwd_1235", for: "genericPassword")
        let password = try keyChainStoreWithGenericPwd.getValue(for: "genericPassword")
        XCTAssertEqual("pwd_1235", password)
      } catch (let e) {
        XCTFail("Updating generic password failed with \(e.localizedDescription).")
      }
    }

    // 4
    func testRemoveGenericPassword() {
      do {
        try keyChainStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
        try keyChainStoreWithGenericPwd.removeValue(for: "genericPassword")
        XCTAssertNil(try keyChainStoreWithGenericPwd.getValue(for: "genericPassword"))
      } catch (let e) {
        XCTFail("Saving generic password failed with \(e.localizedDescription).")
      }
    }


    // 5
    func testRemoveAllGenericPasswords() {
      do {
        try keyChainStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
        try keyChainStoreWithGenericPwd.setValue("pwd_1235", for: "genericPassword2")
        try keyChainStoreWithGenericPwd.removeAllValues()
        XCTAssertNil(try keyChainStoreWithGenericPwd.getValue(for: "genericPassword"))
        XCTAssertNil(try keyChainStoreWithGenericPwd.getValue(for: "genericPassword2"))
      } catch (let e) {
        XCTFail("Removing generic passwords failed with \(e.localizedDescription).")
      }
    }
    

}
