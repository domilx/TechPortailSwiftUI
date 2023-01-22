// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let newEvent = try? JSONDecoder().decode(NewEvent.self, from: jsonData)

import Foundation
import SwiftUI

// MARK: - NewEvent
struct NewEvent: Codable {
    let name, description: String?
    let absents, presents: [JSONAny]?
    let date_debut, date_fin, type, lien: String?
    let local: String?
    let users: [JSONAny]?
    let categories: [String]?

    enum CodingKeys: String, CodingKey {
        case name, description, absents, presents
        case date_debut
        case date_fin
        case type, lien, local, users, categories
    }
}
