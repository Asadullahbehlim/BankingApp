//
//  CreateAccountRequest.swift
//  BankingApp
//
//  Created by Asadullah Behlim on 08/06/22.
//

import Foundation

struct CreateAccountRequest: Codable {
    
    let name: String
    let balance: Double
    let accountType: String
}
