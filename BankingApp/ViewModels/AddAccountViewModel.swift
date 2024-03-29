
//
//  AddAccountViewModel.swift
//  BankingApp
//
//  Created by Asadullah Behlim on 09/06/22.
//

import Foundation

class AddAccountViewModel: ObservableObject {
    var name: String = ""
    var accountType: AccountType = .checking
    var balance: String = ""
    @Published var errorMessage: String = ""
}

extension AddAccountViewModel {
    private var isNameValid: Bool {
        !name.isEmpty
    }
    private var isBalanceValid: Bool {
        guard let userBalance = Double(balance) else {
            return false
        } // Computed property
        return userBalance <= 0 ? false:true
    }
    
    private func isValid() -> Bool {
        var errors = [String]()
        if !isNameValid {
                errors.append("Name is not valid")
            }
        if !isBalanceValid {
            errors.append("Balance is not valid")
        }
        
        if !errors.isEmpty {
            DispatchQueue.main.async {
                self.errorMessage = errors.joined(separator: "\n")
            }
            
            return false
        }
        return true
    }
}

 extension AddAccountViewModel {
    func createAccount(Completion: @escaping (Bool)-> Void) {
        
        if !isValid() {
            return Completion(false)
        }
      
        let createAccountReq = CreateAccountRequest(name: name, balance: Double(balance)!, accountType: accountType.rawValue)
        
        AccountService.shared.createAccount(createAccountRequest: createAccountReq) {
            result in
            switch result{
            case .success(let response) :
                if response.success {
                    Completion(true)
                } else {
                    if let error = response.error
                    {
                        DispatchQueue.main.async {
                            self.errorMessage = error
                        }
                       
                        Completion(false)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
