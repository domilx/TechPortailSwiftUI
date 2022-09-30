//
//  AuthService.swift
//  Tech Portail
//
//  Created by Domenico Valentino on 2022-09-27.
//

import Foundation
import SwiftUI
import Alamofire

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

struct LoginRequestBody: Codable {
    let email: String
    let password: String
}

struct LoginResponse: Codable {
    let token: String?
    let message: String?
    let success: Bool?
}

struct User: Codable {
    let expiresIn: Int?
    let token, userID, userRole, userName: String?

    enum CodingKeys: String, CodingKey {
        case expiresIn, token
        case userID = "userId"
        case userRole, userName
    }
}

let defaults = UserDefaults.standard

class AuthService {
    
    var userInfo: User?

    func login(email: String, password: String, completion: @escaping (Result<String, AuthenticationError>) -> Void) {

        guard let url = URL(string: "http://techapi-env.eba-wuyzhh27.us-east-1.elasticbeanstalk.com/core/auth/login") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }

        let body = LoginRequestBody(email: email, password: password)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)

        URLSession.shared.dataTask(with: request) { (data, response, error) in

            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }

            try! JSONDecoder().decode(User.self, from: data)
            guard let loginResponse = try? JSONDecoder().decode(User.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }

            guard let token = loginResponse.token else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            guard let userName = loginResponse.userName else {
                completion(.failure(.invalidCredentials))
                return
            }
                    
            guard let userId = loginResponse.userID else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            
            defaults.setValue(token, forKey: "jsonwebtoken")
            defaults.setValue(userId, forKey: "userId")
            defaults.setValue(userName, forKey: "userName")
            
            self.setUserData(loginResponse: loginResponse)
            completion(.success(token))
                    

        }.resume()

    }
    
    func setUserData (loginResponse: User) {
        self.userInfo = loginResponse
    }
    
    func getUserData() -> User? {
        print(userInfo)
        return userInfo
    }
}
