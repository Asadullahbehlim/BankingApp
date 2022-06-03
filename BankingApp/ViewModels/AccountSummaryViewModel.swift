//
//  AccountSummaryViewModel.swift
//  BankingApp
//
//  Created by Asadullah Behlim on 03/06/22.
//

import Foundation

class AccountSummaryViewModel : ObservableObject {

    private var _accountsModel = [Account]()
    @Published var accounts: [AccountViewModel] = [AccountViewModel]()
  //  var accounts = [AccountViewModel]

var total: Double {
    _accountsModel.map({$0.balance}).reduce(0,+)
    }


    func getAllAccounts(){
           AccountService.shared.getAllAccounts{ result in
               switch result{
               case .success(let accounts):
                   if let accounts = accounts{
                   self._accountsModel = accounts
                   self.accounts = accounts.map(AccountViewModel.init)
                   }
               case .failure(let error):
                   print(error.localizedDescription)
               }
           }
       }
}

class AccountViewModel {
    var account : Account
    init(account: Account) {
        self.account =  account
        
    }
    var name: String {
        account.name
    }
    var accountId: String {
        account.id.uuidString
    }
    var accountType: String {
        account.accountType.title
    }
    var balance: Double {
        account.balance
    }
}







