//
//  TeamStatisticResponse.swift
//  FootballApplication
//
//  Created by Mehmet Baturay Yasar on 28/12/2022.
//

import Foundation

// MARK: - TeamDetailResponse
struct TeamDetailResponse: Codable {
    let teamDetailResponseGet: String?
    let parameters: Parameters?
    let errors: [JSONAny]?
    let results: Int?
    let response: [TeamResponse]?

    enum CodingKeys: String, CodingKey {
        case teamDetailResponseGet = "get"
        case parameters, errors, results, response
    }
}

// MARK: - Response
struct TeamResponse: Codable {
    let team: Team?
    let venue: TeamDetailVenue?
}

// MARK: - Team
struct Team: Codable {
    let id: Int?
    let name, code, country: String?
    let founded: Int?
    let national: Bool?
    let logo: String?
}

// MARK: - Venue
struct TeamDetailVenue: Codable {
    let id: Int?
    let name, address, city: String?
    let capacity: Int?
    let surface: String?
    let image: String?
}
