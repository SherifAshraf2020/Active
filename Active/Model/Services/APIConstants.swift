//
//  APIConstants.swift
//  Active
//
//  Created by Sherif Ashraf Farooq  on 09/05/2026.
//

import Foundation

struct APIConstants {
    
    static let leaguesBaseURL = "https://apiv2.allsportsapi.com/"
    
    static let apiKey = "f69af4d4e154aa04352c419df0d512db4c47ae29f35fd536d7ba2cd1b2de974e"
    
    static func getLeaguesURL(for sport: String) -> String {
        return "\(leaguesBaseURL)\(sport.lowercased())/?met=Leagues&APIkey=\(apiKey)"
    }
}
