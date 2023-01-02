//
//  TeamsAPI.swift
//  FootballApp
//
//  Created by Mehmet Baturay Yasar on 18/12/2022.
//

import Foundation
import Moya

enum TeamsAPI {
    case teamStatistic(teamStatistic: TeamStatisticRequest)
}

extension TeamsAPI:BaseTarget {
    //override method, in case that you have to use another method as .post
    var method: Moya.Method {
        switch self {
        case .teamStatistic:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .teamStatistic:
            return "teams"
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .teamStatistic(let teamStatisticRequest):
            return teamStatisticRequest.urlEncodedQueryString
        }
    }
}
