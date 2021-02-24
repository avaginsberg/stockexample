//
//  Services.swift
//  Stockdo
//
//  Created by Dayton on 24/02/21.
//

import Foundation

struct Service {
   
    static func loadURL() {
        let stocksURL = URL(string: "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=MSFT&interval=5min&apikey=demo")
        URLSession.shared.dataTask(with: stocksURL!) { (data, response, error) in
          if let error = error {
            print(error)
            return
          }
          do {
            let response = try JSONDecoder().decode(IntradayStock.self, from: data!)
            response.intradayTimeSeries.forEach({ (keyValue) in
              print(keyValue)
            })
          } catch {
            print(error)
          }
        }.resume()
      }

   static func loadDaily() {
        let stocksURL = URL(string: "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY_ADJUSTED&symbol=IBM&apikey=demo")
        URLSession.shared.dataTask(with: stocksURL!) { (data, response, error) in
          if let error = error {
            print(error)
            return
          }
          do {
            let response = try JSONDecoder().decode(DailyStock.self, from: data!)
            response.dailyTimeSeries.forEach({ (keyValue) in
              print(keyValue)
            })
          } catch {
            print(error)
          }
        }.resume()
      }

}
