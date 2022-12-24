//
//  UserModel.swift
//  TechPortail
//
//  Created by Domenico Valentino on 2022-09-29.
//

import Foundation


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
    let userRole: String?
}

struct UserModel: Codable {
    let expiresIn: Int?
    let token, userID, userRole, userName: String?

    enum CodingKeys: String, CodingKey {
        case expiresIn, token
        case userID = "userId"
        case userRole, userName
    }
}
