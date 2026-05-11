//
//  TeamDetailsPresenter.swift
//  Active
//
//  Created by Sherif Ashraf Farooq  on 11/05/2026.
//

import Foundation

// Protocol to define the actions the View must perform
protocol TeamDetailsViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func displayTeamDetails(team: TDTeam)
    func showError(message: String)
}

class TeamDetailsPresenter {
    
    // Weak reference to prevent memory leaks (Retain Cycle)
    weak var view: TeamDetailsViewProtocol?
    private let teamId: Int
    private let service: TeamDetailsService
    
    // Injecting dependencies through the initializer
    init(view: TeamDetailsViewProtocol, teamId: Int, service: TeamDetailsService = .shared) {
        self.view = view
        self.teamId = teamId
        self.service = service
    }
    
    // Called when the view is ready (viewDidLoad)
    func getTeamDetails() {
        view?.showLoading()
        
        service.getTeamDetails(teamId: teamId) { [weak self] result in
            guard let self = self else { return }
            self.view?.hideLoading()
            
            switch result {
            case .success(let response):
                // Ensure we have a team in the result array
                if let team = response.result?.first {
                    self.view?.displayTeamDetails(team: team)
                } else {
                    self.view?.showError(message: "No data found for this team.")
                }
                
            case .failure(let error):
                self.view?.showError(message: error.localizedDescription)
            }
        }
    }
}
