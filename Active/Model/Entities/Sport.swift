//
//  Sport.swift
//  Active
//
//  Created by Sherif Ashraf Farooq  on 05/05/2026.
//

import Foundation

struct SportResponse: Codable {
    let sports: [Sport]
}

struct Sport: Codable {
    let idSport: String
    let strSport: String
    let strSportThumb: String
}
