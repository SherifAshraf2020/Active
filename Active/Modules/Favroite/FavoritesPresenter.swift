//
//  FavoritesPresenter.swift
//  Active
//
//  Created by Sherif Ashraf Farooq  on 08/05/2026.
//

import Foundation

protocol FavoritesViewProtocol: AnyObject {
    func showFavoriteLeagues(_ leagues: [League])
    func showEmptyState()
}

class FavoritesPresenter {
    weak var view: FavoritesViewProtocol?
    
    init(view: FavoritesViewProtocol) {
        self.view = view
    }
    
    func getFavorites() {
        let leagues = CoreDataManager.shared.fetchFavorites()
        if leagues.isEmpty {
            view?.showEmptyState()
        } else {
            view?.showFavoriteLeagues(leagues)
        }
    }
    
    func deleteFromFavorites(league: League) {
        CoreDataManager.shared.deleteLeague(league: league)
        getFavorites()
    }
}
