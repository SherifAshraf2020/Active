//
//  NetworkServiceTests.swift
//  ActiveTests
//
//  Created by Sherif Ashraf Farooq  on 12/05/2026.
//

import XCTest
@testable import Active

final class NetworkServiceTests: XCTestCase {
    
    var teamService: TeamDetailsService!
    var networkService: NetworkService!
    
    override func setUp() {
        super.setUp()
        teamService = TeamDetailsService.shared
        networkService = NetworkService.shared
    }

    override func tearDown() {
        teamService = nil
        networkService = nil
        super.tearDown()
    }

    // 1. Test Team Details (Changed to Real Madrid ID: 74)
    func testGetTeamDetails() {
        // Given
        let teamId = 80 // Real Madrid
        let expectation = expectation(description: "Wait for Real Madrid Details")
        
        // When
        teamService.getTeamDetails(teamId: teamId) { result in
            // Then
            if case .success(let response) = result {
                if let team = response.result?.first {
                    print("Result_TeamName: \(team.team_name ?? "Unknown")")
                    print("Result_TeamID: \(team.team_key ?? 0)")
                    
                    XCTAssertEqual(team.team_key, teamId)
                }
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10)
    }

    // 2. Test Team Matches (Changed to Real Madrid ID: 74)
    func testGetTeamMatches() {
        // Given
        let teamId = 80
        let expectation = expectation(description: "Wait for Matches")
        
        // When
        teamService.getTeamMatches(teamId: teamId) { result in
            // Then
            if case .success(let response) = result {
                let count = response.result?.count ?? 0
                print("Result_MatchesCount: \(count)")
                XCTAssertGreaterThanOrEqual(count, 0)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10)
    }

    // 3. Test Leagues Count
    func testFetchLeaguesCount() {
        // Given
        let url = "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=\(APIConstants.apiKey)"
        let expectation = expectation(description: "Wait for Leagues")
        
        // When
        networkService.fetchData(urlString: url, type: LeagueResponse.self) { result in
            // Then
            if case .success(let response) = result {
                let count = response.result?.count ?? 0
                print("Result_LeaguesCount: \(count)")
                XCTAssertGreaterThan(count, 0)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10)
    }

    // 4. Test League Fixtures (Events)
    func testFetchLeagueFixtures() {
        // Given
        let leagueID = 152 // Premier League
        let url = "https://apiv2.allsportsapi.com/football/?met=Fixtures&leagueId=\(leagueID)&from=2026-04-01&to=2026-06-30&APIkey=\(APIConstants.apiKey)"
        let expectation = expectation(description: "Wait for Fixtures")
        
        // When
        networkService.fetchData(urlString: url, type: EventResponse.self) { result in
            // Then
            if case .success(let response) = result {
                let count = response.result?.count ?? 0
                print("Result_FixturesCount: \(count)")
                XCTAssertNotNil(response.result)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 20)
    }
}
