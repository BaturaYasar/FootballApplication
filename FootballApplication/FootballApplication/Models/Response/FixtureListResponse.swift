//
//  FixtureListResponse.swift
//  FootballApplication
//
//  Created by Mehmet Baturay Yasar on 26/12/2022.
//

import Foundation

// MARK: - FixtureListResponse
struct FixtureListResponse: Codable {
    let fixtureListResponseGet: String?
    let parameters: Parameters?
    let errors: [JSONAny]?
    let results: Int?
    let paging: Paging?
    let response: [Response]?

    enum CodingKeys: String, CodingKey {
        case fixtureListResponseGet = "get"
        case parameters, errors, results, paging, response
    }
}


// MARK: - Fixture
struct Fixture: Codable {
    let id: Int?
    let referee: String?
    let timezone: String?
    let date: String?
    let timestamp: Int?
    let periods: Periods?
    let venue: Venue?
    let status: Status?
}

// MARK: - Periods
struct Periods: Codable {
    let first, second: Int?
}

// MARK: - Status
struct Status: Codable {
    let long, short: String?
    let elapsed: Int?
}

// MARK: - Venue
struct Venue: Codable {
    let id: Int?
    let name, city: String?
}

// MARK: - Goals
struct Goals: Codable {
    let home, away: Int?
}



// MARK: - Score
struct Score: Codable {
    let halftime, fulltime: Goals?
}


// MARK: - Teams
struct Teams: Codable {
    let home, away: Away?
}

// MARK: - Away
struct Away: Codable {
    let id: Int?
    let name: String?
    let logo: String?
    let winner: Bool?
}



