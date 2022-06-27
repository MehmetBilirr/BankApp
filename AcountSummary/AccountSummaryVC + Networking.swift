//
//  AccountSummaryVC + Networking.swift
//  BankApp
//
//  Created by Mehmet Bilir on 27.06.2022.
//

import Foundation
import UIKit

enum NetworkError:Error {
    case serverError
    case decodingError
}


struct Profile:Codable {
    let id:String
    let firstName:String
    let lastName:String
    
    enum CodingKeys:String,CodingKey {
        
        case id
        case firstName = "first_name"
        case lastName = "last_name"
    }
}

extension AccountSummaryVC {
    func fetchProfile(userID:String, completion: @escaping (Result<Profile,NetworkError>) -> Void) {
        let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/bankey/profile/\(userID)")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.serverError))
                return
            }
            DispatchQueue.main.async {
                do {
                    let profile = try JSONDecoder().decode(Profile.self, from: data)
                    completion(.success(profile))
                }catch {
                    completion(.failure(.decodingError))
                }
            }
            
        }.resume()
    }
}


struct Account:Codable {
    let id:String
    let type:AccountType
    let name:String
    let amount:Decimal
    let createdDateTime:Date
    
}

extension AccountSummaryVC {
    
    func fetchAccounts(userID:String, completion: @escaping (Result<[Account],NetworkError>) -> Void) {
        let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/bankey/profile/\(userID)/accounts")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.serverError))
                return
            }
            DispatchQueue.main.async {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let accounts = try decoder.decode([Account].self, from: data)
                    completion(.success(accounts))
                }catch {
                    completion(.failure(.decodingError))
                }
            }
            
        }.resume()
    }
}
    

