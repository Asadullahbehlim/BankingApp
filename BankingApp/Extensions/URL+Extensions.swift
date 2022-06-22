
//  URL+Extensions.swift

//  BankingApp

//  Created by Asadullah Behlim on 02/06/22.


import Foundation

extension URL {
    
    static func urlForAccounts() -> URL? {
         return URL(string: "https://cord-flicker-blinker.glitch.me/api/accounts")
    }
    
    static func urlForCreateAccounts() -> URL? {
        return URL(string: "https://cord-flicker-blinker.glitch.me/api/accounts")
    }
    static func urlForTransferFunds() -> URL? {
        return URL(string: "https://cord-flicker-blinker.glitch.me/api/transfer")
    }
}
