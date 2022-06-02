//
//  Double+Extensions.swift

//  BankingApp
//
//  Created by Asadullah Behlim on 02/06/22.
//

import Foundation

extension Double {
    
    func formatAsCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        let formattedCurrency = formatter.string(from: self as NSNumber)
        return formattedCurrency ?? ""
    }
    
}
