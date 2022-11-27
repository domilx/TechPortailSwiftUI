// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let news = try? newJSONDecoder().decode(News.self, from: jsonData)

import Foundation

// MARK: - News
struct News: Codable {
    let nouvelle: [Nouvelle]?
    let total: Int?
}

// MARK: - Nouvelle
struct Nouvelle: Codable {
    let id, name, nouvelleDescription, date: String?
    let createdBy: CreatedBy?
    let v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case nouvelleDescription = "description"
        case date
        case createdBy = "created_by"
        case v = "__v"
    }
}
