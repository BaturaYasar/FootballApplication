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
        "X-RapidAPI-Key": "4d0d5ea12cmsh428363f07a05d6bp1a6fd8jsnc7eaa04c8974",
        "X-RapidAPI-Host": "api-football-beta.p.rapidapi.com"
    ]}
    var sampleData: Data {Data()}
    var method: Moya.Method {.get}
}
