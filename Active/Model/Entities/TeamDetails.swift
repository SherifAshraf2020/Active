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

struct TDTeam: Codable {
    let team_key: Int?
    let team_name: String?
    let team_logo: String?
    let venue_name: String?
    let team_founded: String?
    let players: [TDPlayer]?
    let coaches: [TDCoach]?
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
}
