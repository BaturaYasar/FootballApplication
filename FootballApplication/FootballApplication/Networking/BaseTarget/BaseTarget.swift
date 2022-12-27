//
//  BaseTarget.swift
//  FootballApp
//
//  Created by Mehmet Baturay Yasar on 18/12/2022.
//

import Foundation
import Moya

public protocol BaseTarget:TargetType {
    
}

public extension BaseTarget {
    var baseURL: URL {
        if let url = URL(string: "https://api-football-beta.p.rapidapi.com") {
            return url
        }else {
            return URL(string: "https://api-football-beta.p.rapidapi.com")!
        }
    }
    var headers: [String : String]? {[
        "X-RapidAPI-Key": "155d2168bbmshc6d6702ed9fa1e4p1e1a44jsnee4d94fb2f76",
        "X-RapidAPI-Host": "api-football-beta.p.rapidapi.com"
    ]}
    var sampleData: Data {Data()}
    var method: Moya.Method {.get}
}
