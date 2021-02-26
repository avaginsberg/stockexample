//
//  DailyAdjustedViewModel.swift
//  Stockdo
//
//  Created by Dayton on 25/02/21.
//

import UIKit

struct DailyAdjustedViewModel {
    let firstSymbol: DailyAdjusted?
    let secondSymbol: DailyAdjusted?
    let thirdSymbol: DailyAdjusted?
    
    private let displayFormatter = DateFormatter().with {
        $0.dateFormat = "yyyy-MM-dd"
        $0.locale = Locale(identifier: "en_US_POSIX")
    }
    
    init(firstSymbol:DailyAdjusted? = nil, secondSymbol:DailyAdjusted? = nil, thirdSymbol:DailyAdjusted? = nil) {
        self.firstSymbol = firstSymbol
        self.secondSymbol = secondSymbol
        self.thirdSymbol = thirdSymbol
    }
    
    var getFirstDate:String? {
        if let date = firstSymbol?.date {
            return displayFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
    var getFirstOpen:String? {
        if let open = firstSymbol?.open {
            let value = String(format: "%.2f", open)
            return "Open:   \(value)"
        } else {
            return nil
        }
    }
    
    var getFirstLow:String? {
        if let low = firstSymbol?.low {
            let value = String(format: "%.2f", low)
            return "Low:   \(value)"
        } else {
            return nil
        }
    }
    
    var getSecondDate:String? {
        if let date = secondSymbol?.date {
            return displayFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
    var getSecondOpen:String? {
        if let open = secondSymbol?.open {
            let value = String(format: "%.2f", open)
            return "Open:   \(value)"
        } else {
            return nil
        }
    }
    
    var getSecondLow:String? {
        if let low = secondSymbol?.low {
            let value = String(format: "%.2f", low)
            return "Low:   \(value)"
        } else {
            return nil
        }
    }
    
    var getThirdDate:String? {
        if let date = thirdSymbol?.date {
            return displayFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
    var getThirdOpen:String? {
        if let open = thirdSymbol?.open {
            let value = String(format: "%.2f", open)
            return "Open:   \(value)"
        } else {
            return nil
        }
    }
    
    var getThirdLow:String? {
        if let low = thirdSymbol?.low {
            let value = String(format: "%.2f", low)
            return "Low:   \(value)"
        } else {
            return nil
        }
    }
    
    var getDateColor: UIColor {
        return UIColor.white
    }
    
    var getOpenColor:UIColor {
        return UIColor.yellow
    }
    
    func getLowColor(section:DailySection) -> UIColor {
        switch section {
        case .firstSection:
            if let open = firstSymbol?.open, let low = firstSymbol?.low {
                if open > low {
                    return UIColor.red
                } else {
                    return UIColor.yellow
                }
            } else {
                return UIColor.clear
            }
        case .secondSection:
            if let open = secondSymbol?.open, let low = secondSymbol?.low {
                if open > low {
                    return UIColor.red
                } else {
                    return UIColor.yellow
                }
            }else {
                return UIColor.clear
            }
        case .thirdSection:
            if let open = thirdSymbol?.open, let low = thirdSymbol?.low {
                if open > low {
                    return UIColor.red
                } else {
                    return UIColor.yellow
                }
            }else {
                return UIColor.clear
            }
        }
    }
    
}

