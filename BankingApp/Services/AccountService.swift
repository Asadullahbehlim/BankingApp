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
    func getAllAccounts(completion: @escaping (Result<[Account],NetworkError>) -> Void) {
        
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

