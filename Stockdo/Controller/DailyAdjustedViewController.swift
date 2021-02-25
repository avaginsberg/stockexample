//
//  DailyAdjustedViewController.swift
//  Stockdo
//
//  Created by Dayton on 24/02/21.
//

import UIKit

class DailyAdjustedViewController: UIViewController {
   
    //MARK: - Properties
    private lazy var dailyFormatter = DateFormatter().with {
        $0.dateFormat = "yyyy-MM-dd"
        $0.locale = Locale(identifier: "en_US_POSIX")
    }
 
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        configureNavigationBar(withTitle: "Daily Adjusted", prefersLargeTitles: true)
        Service.fetchDailyStock(dailyFormatter) { dailyStocks in
            print(dailyStocks)
            
        }
    }
    
  
   
}


