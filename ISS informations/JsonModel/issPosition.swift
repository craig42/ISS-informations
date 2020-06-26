// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let issJSONPosition = try? newJSONDecoder().decode(IssJSONPosition.self, from: jsonData)

import Foundation

// MARK: - IssJSONPosition
struct IssJSONPosition: Codable {
    let message: String
    let timestamp: Int
    let issPosition: IssPosition

    enum CodingKeys: String, CodingKey {
        case message, timestamp
        case issPosition
    }
}

// MARK: - IssPosition
struct IssPosition: Codable {
    let longitude, latitude: String
}
