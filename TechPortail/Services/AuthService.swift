//
//  AuthService.swift
//  TechPortail
//
//  Created by Domenico Valentino on 2022-09-27.
//

import Foundation
import SwiftUI
import Alamofire

class AuthService {
    
    @AppStorage("token") var tokenS: String = "null"
    @AppStorage("userName") var userNameS: String = "null"
    @AppStorage("userId") var userIdS: String = "null"
    @AppStorage("isMentor") var isMentor: Bool = false
    @AppStorage("isLoggedIn") var loggedInS: Bool = false

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
            
            guard let loginResponse = try? JSONDecoder().decode(UserModel.self, from: data) else {
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
            
            guard let userRole = loginResponse.userRole else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            
            self.loggedInS = true
            self.userNameS = userName
            self.userIdS = userId
            self.userNameS = userName
            self.tokenS = token
            if(userRole == "eleve"){
                self.isMentor = false
            } else if(userRole == "mentor") {
                self.isMentor = true
            }
            
            completion(.success(token))
                    

        }.resume()

    }
}
