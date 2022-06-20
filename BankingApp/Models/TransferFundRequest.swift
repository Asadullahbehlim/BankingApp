//
//  TransferFundRequest.swift
//  BankingApp
//
//  Created by Asadullah Behlim on 17/06/22.
//

import Foundation

struct TransferFundRequest : Codable{
let accountFromId:String
let accountToId:String
let amount:Double
}
