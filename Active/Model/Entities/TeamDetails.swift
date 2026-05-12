//
//  TeamDetails.swift
//  Active
//
//  Created by Sherif Ashraf Farooq  on 11/05/2026.
//

import Foundation

struct TDTeamResponse: Codable {
    let success: Int?
    let result: [TDTeam]?
}

struct TDMatchResponse: Codable {
    let success: Int?
    let result: [TDMatch]?
}

struct TDTeam: Codable {
    let team_key: Int?
    let team_name: String?
    let team_logo: String?
    let venue_name: String?
    let team_founded: String?
    let players: [TDPlayer]?
    let coaches: [TDCoach]?
    
    var lastMatches: [TDMatch]?
    var nextMatches: [TDMatch]?
}

struct TDPlayer: Codable {
    let player_key: Int?
    let player_name: String?
    let player_number: String?
    let player_type: String? // Position
    let player_image: String?
}

struct TDCoach: Codable {
    let coach_name: String?
}

struct TDMatch: Codable {
    let event_key: Int?
    let event_home_team: String?
    let event_away_team: String?
    let home_team_logo: String?
    let away_team_logo: String?
    let event_date: String?
    let event_final_result: String?

    init(event_key: Int? = nil, event_home_team: String? = nil, event_away_team: String? = nil, home_team_logo: String? = nil, away_team_logo: String? = nil, event_date: String? = nil, event_final_result: String? = nil) {
        self.event_key = event_key
        self.event_home_team = event_home_team
        self.event_away_team = event_away_team
        self.home_team_logo = home_team_logo
        self.away_team_logo = away_team_logo
        self.event_date = event_date
        self.event_final_result = event_final_result
    }
}
