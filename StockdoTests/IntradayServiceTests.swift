//
//  ServiceTests.swift
//  StockdoTests
//
//  Created by Dayton on 26/02/21.
//

import XCTest
@testable import Stockdo

class IntradayServiceTests: XCTestCase {
    
    var session: URLSession!

    override func setUp() {
      super.setUp()
      
        session = URLSession(configuration: .default)
    }

    override func tearDown() {
        session = nil
      
      super.tearDown()
    }

    func testValidCallToIntradayStock() {
      let url = URL(string: "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=IBM&interval=5min&apikey=demo")
      
      let promise = expectation(description: "Status code: 200")
      
      
      let dataTask = session.dataTask(with: url!) { data, response, error in
       
        if let error = error {
          XCTFail("Error: \(error.localizedDescription)")
          return
        } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
          if statusCode == 200 {
          
            promise.fulfill()
          } else {
            XCTFail("Status code: \(statusCode)")
          }
        }
      }
      dataTask.resume()
    
      wait(for: [promise], timeout: 10)
    }

  
   func testCallToIntradayStockCompletes() {
       
        let url = URL(string: "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=IBM&interval=5min&apikey=demo")
        
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
      
        let dataTask = session.dataTask(with: url!) { data, response, error in
          statusCode = (response as? HTTPURLResponse)?.statusCode
          responseError = error
         
          promise.fulfill()
        }
        dataTask.resume()
        
        wait(for: [promise], timeout: 5)
       
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
      }

}

