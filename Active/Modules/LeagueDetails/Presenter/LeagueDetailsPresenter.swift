//
//  LeagueDetailsPresenter.swift
//  Active
//
//  Created by Yomna on 10/05/2026.
//

import Foundation

protocol LeagueDetailsPresenterProtocol {

    func viewDidLoad()

    func getUpcomingCount() -> Int

    func getLatestCount() -> Int

    func getTeamsCount() -> Int

    func getUpcomingEvent(at index: Int) -> Event

    func getLatestEvent(at index: Int) -> Event

    func getTeam(at index: Int) -> Team
    
    func toggleFavorite(
        league: LeagueModel
    ) -> Bool

    func isFavorite(
        league: LeagueModel
    ) -> Bool
}

class LeagueDetailsPresenter: LeagueDetailsPresenterProtocol {

    // MARK: - Properties

    weak var view: LeagueDetailsViewProtocol?

    private let networkService: NetworkServiceProtocol

    private let leagueID: Int


    // MARK: - Data

    private var upcomingEvents: [Event] = []

    private var latestEvents: [Event] = []

    private var teams: [Team] = []


    // MARK: - Init

    init(
        view: LeagueDetailsViewProtocol,
        networkService: NetworkServiceProtocol = NetworkService.shared,
        leagueID: Int
    ) {

        self.view = view

        self.networkService = networkService

        self.leagueID = leagueID
    }


    // MARK: - ViewDidLoad

    func viewDidLoad() {

        view?.startLoading()

        let group = DispatchGroup()

        group.enter()
        fetchFixtures(group: group)

        group.enter()
        fetchTeams(group: group)

        group.notify(queue: .main) {
            self.view?.reloadData()
            self.view?.stopLoading()
        }
    }
}


// MARK: - Fetch Data

extension LeagueDetailsPresenter {


    private func fetchFixtures(
        group: DispatchGroup
    ) {

        let url =
        "https://apiv2.allsportsapi.com/football/?met=Fixtures&leagueId=\(leagueID)&from=2026-04-01&to=2026-06-30&APIkey=\(APIConstants.apiKey)"

        print(url)

        networkService.fetchData(
            urlString: url,
            type: EventResponse.self
        ) { [weak self] result in

            switch result {

            case .success(let response):

                guard let self = self else {
                    group.leave()
                    return
                }

                let allFixtures = response.result ?? []

                let formatter = DateFormatter()

                formatter.dateFormat = "yyyy-MM-dd"

                let today = Date()

                self.upcomingEvents = allFixtures.filter {

                    guard let dateString = $0.event_date,
                          let matchDate = formatter.date(
                            from: dateString
                          )
                    else {
                        return false
                    }

                    return matchDate >= today
                }

                self.latestEvents = allFixtures.filter {

                    guard let dateString = $0.event_date,
                          let matchDate = formatter.date(
                            from: dateString
                          )
                    else {
                        return false
                    }

                    return matchDate < today
                }

                print(
                    "Upcoming Count: \(self.upcomingEvents.count)"
                )

                print(
                    "Latest Count: \(self.latestEvents.count)"
                )


                group.leave()


            case .failure(let error):

                DispatchQueue.main.async {

                    self?.view?.showError(
                        message: error.localizedDescription
                    )
                }

                group.leave()
            }
        }
    }


    private func fetchTeams(
        group: DispatchGroup
    ) {

        let url =
        "https://apiv2.allsportsapi.com/football/?met=Teams&leagueId=\(leagueID)&APIkey=\(APIConstants.apiKey)"

        print(url)

        networkService.fetchData(
            urlString: url,
            type: TeamResponse.self
        ) { [weak self] result in

            switch result {

            case .success(let response):

                self?.teams = response.result ?? []

                print(
                    "Teams Count: \(self?.teams.count ?? 0)"
                )

            

                group.leave()


            case .failure(let error):

                DispatchQueue.main.async {

                    self?.view?.showError(
                        message: error.localizedDescription
                    )
                }

                group.leave()
            }
        }
    }
}


// MARK: - Counts

extension LeagueDetailsPresenter {


    func getUpcomingCount() -> Int {

        return upcomingEvents.count
    }


    func getLatestCount() -> Int {

        return latestEvents.count
    }


    func getTeamsCount() -> Int {

        return teams.count
    }
}


// MARK: - Get Items

extension LeagueDetailsPresenter {


    func getUpcomingEvent(
        at index: Int
    ) -> Event {

        return upcomingEvents[index]
    }


    func getLatestEvent(
        at index: Int
    ) -> Event {

        return latestEvents[index]
    }


    func getTeam(
        at index: Int
    ) -> Team {

        return teams[index]
    }
}

// MARK: - Favorites

extension LeagueDetailsPresenter {

    func isFavorite(
        league: LeagueModel
    ) -> Bool {

        let key = "\(league.leagueKey ?? 0)"

        return CoreDataManager.shared.isLeagueFavorite(
            key: key
        )
    }


    func toggleFavorite(
        league: LeagueModel
    ) -> Bool {

        let key = "\(league.leagueKey ?? 0)"

        // MARK: Remove From Favorites

        if CoreDataManager.shared.isLeagueFavorite(
            key: key
        ) {

            CoreDataManager.shared.deleteLeague(
                by: key
            )

            return false
        }

        // MARK: Add To Favorites

        CoreDataManager.shared.saveLeague(
            key: key,
            name: league.leagueName ?? "",
            logo: league.leagueLogo ?? "",
            sport: "Football"
        )

        return true
    }
}
