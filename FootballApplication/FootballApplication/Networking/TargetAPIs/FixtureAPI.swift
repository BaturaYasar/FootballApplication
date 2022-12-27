//
//  FixtureAPI.swift
//  FootballApp
//
//  Created by Mehmet Baturay Yasar on 18/12/2022.
//

import Foundation
import Moya

enum FixtureAPI {
    case fixtureList(fixtureListRequest: FixtureListRequest)
}

extension FixtureAPI:BaseTarget {
    //override method, in case that you have to use another method as .post
    var method: Moya.Method {
        switch self {
        case .fixtureList:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .fixtureList:
            return "fixtures"
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fixtureList(let fixtureListRequest):
            return fixtureListRequest.urlEncodedQueryString
        }
    }
}
