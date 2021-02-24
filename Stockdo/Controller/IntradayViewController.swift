//
//  IntradayViewController.swift
//  Stockdo
//
//  Created by Dayton on 24/02/21.
//

import UIKit

class IntradayViewController: UIViewController {
   
    //MARK: - Properties
    private lazy var hourFormatter = DateFormatter().with {
        $0.dateFormat = "yyyy-MM-dd HH:mm:ss"
        $0.locale = Locale(identifier: "en_US_POSIX")
    }
 
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        
        Service.fetchIntradayStock(hourFormatter) { intradays in
           
            for intra in intradays {
                self.hourFormatter.dateFormat = "HH:mm"
                let date24 = self.hourFormatter.string(from: intra.date)
                
                print(date24)
                
            }
            
            
        }
    }
    
   
   
}

