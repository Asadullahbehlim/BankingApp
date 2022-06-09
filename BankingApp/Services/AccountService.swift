//
//  AccountService.swift
//  BankingApp
//
//  Created by Asadullah Behlim on 02/06/22.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case noData
    case decodingError
}
 class AccountService {
    private init() {}
    static let shared = AccountService()
    
 func createAccount(createAccountRequest: CreateAccountRequest, completion: @escaping (Result<CreateAccountResponse, NetworkError>) -> Void) {
     
        guard let url = URL.urlForCreateAccounts() else {
            return completion(.failure(.badURL))
        }
        
     var request = URLRequest(url: url)
     request.httpMethod = "POST"
     request.addValue("application/json", forHTTPHeaderField: "Content-Type")
     request.httpBody = try? JSONEncoder().encode(createAccountRequest)
    
     URLSession.shared.dataTask(with: request) {
         data, response, error in
         guard let data = data, error == nil else {
             return completion(.failure(.badURL))
         }
         
         let createAccountResponse = try? JSONDecoder().decode(CreateAccountResponse.self, from: data)
         
      if   let createAccountResponse = createAccountResponse {
             completion(.success(createAccountResponse))
             
         }
         else {
             completion(.failure(.decodingError))
         }
     }
 }
    
    func getAllAccounts(completion: @escaping (Result<[Account]?,NetworkError>) -> Void) {
        
        guard let url = URL.urlForAccounts()
        else {
            return completion(.failure(.badURL))
        }
        URLSession.shared.dataTask(with:url) { data, response, error in
            
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
        guard let accounts = try? JSONDecoder().decode([Account].self, from: data) else {
            return completion(.failure(.decodingError))
            
        }
        return completion(.success(accounts))
                       
        }.resume()
    }
    
}

