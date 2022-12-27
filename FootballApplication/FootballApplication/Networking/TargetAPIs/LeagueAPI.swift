//
//  LeagueAPI.swift
//  FootballApp
//
//  Created by Mehmet Baturay Yasar on 18/12/2022.
//

import Foundation
import Moya

enum LeagueAPI {
    case leagueList(leagueListRequest: LeagueListRequest)
}

extension LeagueAPI:BaseTarget {
    //override method, in case that you have to use another method as .post
    var method: Moya.Method {
        switch self {
        case .leagueList:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .leagueList:
            return "leagues"
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .leagueList(let leagueListRequest):
            return leagueListRequest.urlEncodedQueryString
        }
    }
}
