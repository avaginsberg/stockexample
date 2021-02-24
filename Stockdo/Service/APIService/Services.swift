//
//  Services.swift
//  Stockdo
//
//  Created by Dayton on 24/02/21.
//

import Foundation

struct Service {
    
    static func fetchIntradayStock(_ dateFormatter: DateFormatter,completion: @escaping([Intraday]) -> Void) {
        var intradayStocks = [Intraday]()
        guard let stocksURL = URL(string: "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=MSFT&interval=5min&apikey=demo") else {
            fatalError("URL is not defined")
        }
        URLSession.shared.dataTask(with: stocksURL) { (data, response, error) in
          if let error = error {
            print(error)
            return
          }
          do {
            let response = try JSONDecoder().decode(IntradayStock.self, from: data!)
            response.intradayTimeSeries.forEach({ (keyValue) in
                
                guard let convertedDate = dateFormatter.date(from: keyValue.key) else { return }
                let fetchedValue = keyValue.value
                
                let intraday = Intraday(date: convertedDate, open: fetchedValue.open.doubleValue, high: fetchedValue.high.doubleValue, low: fetchedValue.low.doubleValue)
                
                intradayStocks.append(intraday)
                
            })
            completion(intradayStocks)
          } catch {
            print(error)
          }
        }.resume()
      }

    static func fetchDailyStock(_ dateFormatter: DateFormatter, completion: @escaping([DailyAdjusted]) -> Void) {
        var dailyStocks = [DailyAdjusted]()
        
        guard let stocksURL = URL(string: "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY_ADJUSTED&symbol=IBM&apikey=demo") else {
            fatalError("URL is not defined")
        }
        URLSession.shared.dataTask(with: stocksURL) { (data, response, error) in
          if let error = error {
            print(error)
            return
          }
          do {
            let response = try JSONDecoder().decode(DailyStock.self, from: data!)
            response.dailyTimeSeries.forEach({ (keyValue) in
                guard let convertedDate = dateFormatter.date(from: keyValue.key) else { return }
                let fetchedValue = keyValue.value
                
                let daily = DailyAdjusted(date: convertedDate, open: fetchedValue.open.doubleValue, low: fetchedValue.low.doubleValue)
                
                dailyStocks.append(daily)
               
            })
            completion(dailyStocks)
          } catch {
            print(error)
          }
        }.resume()
      }

}
