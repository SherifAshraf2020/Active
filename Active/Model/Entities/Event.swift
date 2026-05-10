//
//  Event.swift
//  Active
//
//  Created by Yomna on 10/05/2026.
//


import Foundation

struct EventResponse: Codable {

    let success: Int?

    let result: [Event]?
}

struct Event: Codable {

    let event_key: Int?

    let event_date: String?

    let event_time: String?

    let event_home_team: String?

    let event_away_team: String?

    let home_team_logo: String?

    let away_team_logo: String?

    let event_final_result: String?
}
