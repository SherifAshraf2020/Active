//
//  Team.swift
//  Active
//
//  Created by Yomna on 10/05/2026.
//

import Foundation

struct TeamResponse: Codable {

    let success: Int?

    let result: [Team]?
}

struct Team: Codable {

    let team_key: Int?

    let team_name: String?

    let team_logo: String?
}
