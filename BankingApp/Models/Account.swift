//
//  Account.swift
//  BankingApp
//
//  Created by Asadullah Behlim on 02/06/22.
//

import Foundation

enum AccountType: String, Codable, CaseIterable {
    case checking
    case saving
}
struct Account: Codable {
    var id: UUID
    var name: String
    var balance: Double
    let accountType: AccountType
    
}

extension AccountType {
    var title: String {
        switch self {
        case .checking: return "Checking"
        case .saving: return "Saving"
            
        }
    }
}
