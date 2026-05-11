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
    
    /// Fetches team details using the Generic NetworkService
    /// - Parameters:
    ///   - teamId: The ID of the team
    ///   - completion: Result containing TDTeamResponse or Error
    func getTeamDetails(teamId: Int, completion: @escaping (Result<TDTeamResponse, Error>) -> Void) {
        
        // 1. Construct the URL using your APIConstants style
        let urlString = "\(APIConstants.leaguesBaseURL)football/?met=Teams&teamId=\(teamId)&APIkey=\(APIConstants.apiKey)"
        
        // 2. Use your existing Generic NetworkService
        NetworkService.shared.fetchData(urlString: urlString, type: TDTeamResponse.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
