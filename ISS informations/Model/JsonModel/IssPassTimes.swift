// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let issJSONPosition = try? newJSONDecoder().decode(IssJSONPosition.self, from: jsonData)

import Foundation

struct IssPassTimes: Codable {
    let message: String
    let request: Request
    let response: [Response]
}

struct Request: Codable {
    let altitude, datetime : Int
    let latitude, longitude: Double
    let passes: Int
}

struct Response: Codable {
    let duration, risetime: Int
}
