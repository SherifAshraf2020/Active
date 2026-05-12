//
//  TeamDetailsService.swift
//  Active
//
//  Created by Sherif Ashraf Farooq  on 11/05/2026.
//

import Foundation

class TeamDetailsService {
    
    static let shared = TeamDetailsService()
    private init() {}
    
    func getTeamDetails(teamId: Int, completion: @escaping (Result<TDTeamResponse, Error>) -> Void) {
        let urlString = "\(APIConstants.leaguesBaseURL)football/?met=Teams&teamId=\(teamId)&APIkey=\(APIConstants.apiKey)"
        NetworkService.shared.fetchData(urlString: urlString, type: TDTeamResponse.self) { result in
            completion(result)
        }
    }
    
    func getTeamMatches(teamId: Int, completion: @escaping (Result<TDMatchResponse, Error>) -> Void) {
        let urlString = "\(APIConstants.leaguesBaseURL)football/?met=Fixtures&teamId=\(teamId)&from=2025-01-01&to=2026-12-31&APIkey=\(APIConstants.apiKey)"
        
        NetworkService.shared.fetchData(urlString: urlString, type: TDMatchResponse.self) { result in
            completion(result)
        }
    }
}

