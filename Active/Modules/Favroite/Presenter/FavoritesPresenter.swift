//
//  FavoritesPresenter.swift
//  Active
//
//  Created by Sherif Ashraf Farooq  on 08/05/2026.
//

import Foundation

protocol FavoritesViewProtocol: AnyObject {
    func showFavorites(leagues: [League]?, teams: [TeamEntity]?, isLeague: Bool)
    func showEmptyState()
}

class FavoritesPresenter {
    weak var view: FavoritesViewProtocol?
    var currentSegmentIndex = 0 // 0 for Leagues, 1 for Teams
    
    init(view: FavoritesViewProtocol) {
        self.view = view
    }
    
    func getFavorites() {
        if currentSegmentIndex == 0 {
            let leagues = CoreDataManager.shared.fetchFavorites()
            leagues.isEmpty ? view?.showEmptyState() : view?.showFavorites(leagues: leagues, teams: nil, isLeague: true)
        } else {
            let teams = CoreDataManager.shared.fetchFavoriteTeams()
            teams.isEmpty ? view?.showEmptyState() : view?.showFavorites(leagues: nil, teams: teams, isLeague: false)
        }
    }
    
    func deleteLeague(league: League) {
        CoreDataManager.shared.deleteLeague(league: league)
        getFavorites()
    }

    func deleteTeam(team: TeamEntity) {
        CoreDataManager.shared.deleteTeam(team: team)
        getFavorites()
    }
}
