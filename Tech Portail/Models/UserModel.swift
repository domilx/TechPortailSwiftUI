//
//  UserModel.swift
//  Tech Portail
//
//  Created by Domenico Valentino on 2022-09-29.
//

import Foundation

struct UserModel: Codable {
    let expiresIn: Int
    let token, userID, userRole, userName: String

    enum CodingKeys: String, CodingKey {
        case expiresIn, token
        case userID = "userId"
        case userRole, userName
    }
}
