//
//  TeamDetailsPresenter.swift
//  Active
//
//  Created by Sherif Ashraf Farooq  on 11/05/2026.
//

import Foundation

protocol TeamDetailsViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func displayTeamDetails(team: TDTeam)
    func showError(message: String)
}

class TeamDetailsPresenter {
    
    weak var view: TeamDetailsViewProtocol?
    private let teamId: Int
    private let service: TeamDetailsService
    
    init(view: TeamDetailsViewProtocol, teamId: Int, service: TeamDetailsService = .shared) {
        self.view = view
        self.teamId = teamId
        self.service = service
    }
    
    func getTeamDetails() {
        view?.showLoading()
        
        service.getTeamDetails(teamId: teamId) { [weak self] (result: Result<TDTeamResponse, Error>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let teamResponse):
                if var team = teamResponse.result?.first {
                    self.fetchMatches(for: team)
                } else {
                    self.view?.hideLoading()
                    self.view?.showError(message: "Team not found")
                }
            case .failure(let error):
                self.view?.hideLoading()
                self.view?.showError(message: error.localizedDescription)
            }
        }
    }
    
    private func fetchMatches(for team: TDTeam) {
        service.getTeamMatches(teamId: teamId) { [weak self] (result: Result<TDMatchResponse, Error>) in
            guard let self = self else { return }
            self.view?.hideLoading()
            
            var finalTeam = team
            
            switch result {
            case .success(let matchResponse):
                let allMatches = matchResponse.result ?? []
                
                finalTeam.lastMatches = allMatches.filter { match in
                    let res = match.event_final_result ?? ""
                    return !res.isEmpty && res != "-" && res != "?"
                }
                
                finalTeam.nextMatches = allMatches.filter { match in
                    let res = match.event_final_result ?? ""
                    return res == "-" || res.isEmpty || res == "?"
                }
                
                finalTeam.nextMatches = finalTeam.nextMatches?.sorted(by: { ($0.event_date ?? "") < ($1.event_date ?? "") })
                
                print("✅ Sorted: \(finalTeam.lastMatches?.count ?? 0) Results, \(finalTeam.nextMatches?.count ?? 0) Upcoming")
                
                self.view?.displayTeamDetails(team: finalTeam)
                
            case .failure(let error):
                print("❌ Matches fetch error: \(error.localizedDescription)")
                self.view?.displayTeamDetails(team: finalTeam)
            }
        }
    }
}
