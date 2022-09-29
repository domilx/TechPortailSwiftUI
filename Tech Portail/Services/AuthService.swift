//
//  AuthService.swift
//  Tech Portail
//
//  Created by Domenico Valentino on 2022-09-27.
//

import Foundation
import SwiftUI
import Alamofire

struct User: Codable {
    let expiresIn: Int
    let token, userID, userRole, userName: String

    enum CodingKeys: String, CodingKey {
        case expiresIn, token
        case userID = "userId"
        case userRole, userName
    }
}

final class AuthService: ObservableObject {
        
    func loginUser(sendEmail: Binding<String>, sendPass: Binding<String>) {
        
        let params: Parameters = [
                "email": sendEmail.wrappedValue,
                "password": sendPass.wrappedValue
            ]
        print(params)
        AF.request("http://techapi-env.eba-wuyzhh27.us-east-1.elasticbeanstalk.com/core/auth/login", method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200 ..< 299).responseData { response in
            switch response.result {
                case .success(let data):
                    do {
                        guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                            print("Error: Cannot convert data to JSON object")
                            return
                        }
                        guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                            print("Error: Cannot convert JSON object to Pretty JSON data")
                            return
                        }
                        guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                            print("Error: Could print JSON in String")
                            return
                        }
                
                        self.loginSuccess(jsonDataPretty: prettyPrintedJson)
                    } catch {
                        print("Error: Trying to convert JSON data to string")
                        return
                    }
                    case .failure(let error):
                        do {
                            self.loginFailure(error: error)
                        }
            }
        }
    }
    
    func loginFailure(error: AFError) {
        print(error)
    }
    
    func loginSuccess(jsonDataPretty: String) {
        do {
            print(jsonDataPretty)
            let userDataParse = Data(jsonDataPretty.utf8)
            let userData = try JSONDecoder().decode(User.self, from: userDataParse)
            print(userData)
        } catch {
            print(error)
        }
    }
    
}
