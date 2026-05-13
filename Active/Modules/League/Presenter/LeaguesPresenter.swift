////
////  LeaguesPresenter.swift
////  Active
////
////  Created by Yomna on 07/05/2026.
////

import Foundation

protocol LeaguesPresenterProtocol {

    func attachView(_ view: LeaguesViewProtocol)

    func getLeagues(for sport: String)

    func getLeaguesCount() -> Int

    func getLeague(at index: Int) -> LeagueModel
    
    func toggleFavorite(
        league: LeagueModel,
        sport: String
    )

    func isFavorite(
        league: LeagueModel
    ) -> Bool
}

class LeaguesPresenter: LeaguesPresenterProtocol {

    private weak var view: LeaguesViewProtocol?

    private var leagues: [LeagueModel] = []

    private let apiKey = "f69af4d4e154aa04352c419df0d512db4c47ae29f35fd536d7ba2cd1b2de974e"

    func attachView(_ view: LeaguesViewProtocol) {

        self.view = view
    }

    func getLeagues(for sport: String) {

        view?.startLoading()

        let url =
        "https://apiv2.allsportsapi.com/\(sport)/?met=Leagues&APIkey=\(apiKey)"

        NetworkService.shared.fetchData(
            urlString: url,
            type: LeagueResponse.self
        ) { [weak self] result in

            self?.view?.stopLoading()

            switch result {

            case .success(let response):

                self?.leagues = response.result ?? []

                self?.view?.reloadData()

            case .failure(let error):

                self?.view?.showError(
                    message: error.localizedDescription
                )
            }
        }
    }
    
    func getLeaguesCount() -> Int {

        return leagues.count
    }

    func getLeague(at index: Int) -> LeagueModel {

        return leagues[index]
    }
    
    func toggleFavorite(
        league: LeagueModel,
        sport: String
    ) {

        let key = "\(league.leagueKey ?? 0)"

        if CoreDataManager.shared.isLeagueFavorite(
            key: key
        ) {

            CoreDataManager.shared.deleteLeague(
                       by: key
                   )

        } else {

            CoreDataManager.shared.saveLeague(
                key: key,
                name: league.leagueName ?? "",
                logo: league.leagueLogo ?? "",
                sport: sport
            )
        }
    }
    func isFavorite(
        league: LeagueModel
    ) -> Bool {

        let key = "\(league.leagueKey ?? 0)"

        return CoreDataManager.shared.isLeagueFavorite(
            key: key
        )
    }
}
