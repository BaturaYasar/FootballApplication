//
//  NetworkManager.swift
//  FootballApp
//
//  Created by Mehmet Baturay Yasar on 18/12/2022.
//

import Foundation
import Moya

protocol NetworkManagerDelegate {
    
    var provider:MoyaProvider<MultiTarget> {get}
    
    func getLeagueList(request:LeagueListRequest, completition: @escaping (Result<LeagueListResponse, Error>) -> ())
    
    func getFixtureList(request:FixtureListRequest, completition: @escaping (Result<FixtureListResponse, Error>) -> ())
    
}

class NetworkManager:NetworkManagerDelegate {
    static let shared = NetworkManager()
    
    var provider = Moya.MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin(verbose: true, cURL: true)])
    
    func getLeagueList(request: LeagueListRequest, completition: @escaping (Result<LeagueListResponse, Error>) -> ()) {
        requestData(target: LeagueAPI.leagueList(leagueListRequest: request), completion: completition)
    }
    
    func getFixtureList(request: FixtureListRequest, completition: @escaping (Result<FixtureListResponse, Error>) -> ()) {
        requestData(target: FixtureAPI.fixtureList(fixtureListRequest: request), completion: completition)
    }
    
    
}

private extension NetworkManager {
    private func requestData<T: Decodable, M: TargetType>(target: M, completion: @escaping (Result<T, Error>) -> ()) {
        provider.request(MultiTarget(target)) { result in
            switch result {
            case let .success(response):
                do {
                    let result = try JSONDecoder().decode(T.self,from: response.data)
                    completion(.success(result))
                }catch {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

