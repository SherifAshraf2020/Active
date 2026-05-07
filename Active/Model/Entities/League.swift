//
//  League.swift
//  Active
//
//  Created by Yomna on 07/05/2026.
//

import Foundation
struct LeagueResponse : Codable{
    let success: Int?
    let result: [LeagueModel]?
}


struct LeagueModel : Codable{
    let leagueKey : Int?
    let leagueName : String?
    let leagueLogo : String?
    
    enum CodingKeys: String, CodingKey {
           case leagueKey = "league_key"
           case leagueName = "league_name"
           case leagueLogo = "league_logo"
       }
    
}
