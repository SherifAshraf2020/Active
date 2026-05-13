//
//  LeaguesTableViewController.swift
//  Active
//
//  Created by Yomna on 07/05/2026.
//

import UIKit
import Kingfisher
import Foundation

protocol LeaguesViewProtocol: AnyObject {

    func startLoading()

    func stopLoading()

    func reloadData()

    func showError(message: String)
}

class LeaguesTableViewController:
UITableViewController {

    var presenter: LeaguesPresenterProtocol?

    let indicator = UIActivityIndicatorView(style: .large)

    var selectedSport: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = traitCollection.userInterfaceStyle == .dark
        ? UIColor(red: 24/255, green: 24/255, blue: 32/255, alpha: 1)
        : .systemBackground
        tableView.separatorStyle = .none

        title = "Leagues"

        tableView.rowHeight = 90

        presenter = LeaguesPresenter()

        presenter?.attachView(self)

        let nameToFetch = selectedSport?.lowercased() ?? "football"
        presenter?.getLeagues(for: nameToFetch)
    }
    override func viewWillAppear(
        _ animated: Bool
    ) {

        super.viewWillAppear(animated)

        tableView.reloadData()
    }
}

// MARK: - View Protocol

extension LeaguesTableViewController:
LeaguesViewProtocol {

    func startLoading() {

        indicator.center = view.center

        view.addSubview(indicator)

        indicator.startAnimating()
    }

    func stopLoading() {

        indicator.stopAnimating()

        indicator.removeFromSuperview()
    }

    func reloadData() {

        tableView.reloadData()
    }

    func showError(message: String) {
        let alert = UIAlertController(
            title: "Connection Issue",
            message: message,
            preferredStyle: .alert
        )

        let retryAction = UIAlertAction(title: "Retry", style: .default) { [weak self] _ in
            let nameToFetch = self?.selectedSport?.lowercased() ?? "football"
            self?.presenter?.getLeagues(for: nameToFetch)
        }

        let okAction = UIAlertAction(title: "OK", style: .cancel)

        alert.addAction(retryAction)
        alert.addAction(okAction)

        present(alert, animated: true)
    }
}

// MARK: - TableView

extension LeaguesTableViewController {

    override func numberOfSections(
        in tableView: UITableView
    ) -> Int {

        return 1
    }

    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {

        return presenter?.getLeaguesCount() ?? 0
    }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: "LeagueCell",
            for: indexPath
        ) as! LeaguesTableViewCell
        if traitCollection.userInterfaceStyle == .dark {
            cell.contentView.backgroundColor = UIColor(
                red: 30/255,
                green: 30/255,
                blue: 40/255,
                alpha: 1
            )
        } else {
            cell.contentView.backgroundColor = .white
        }
        
        guard let league =
                presenter?.getLeague(at: indexPath.row)
        else {
            return cell
        }

        // MARK: - League Name

        cell.leagueNameLabel.text =
        league.leagueName

        // MARK: - League Image

        if let imageString = league.leagueLogo,
           let url = URL(string: imageString) {

            cell.leagueImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "placeholder")
            )

        } else {

            cell.leagueImageView.image =
            UIImage(named: "placeholder")
        }

        // MARK: - Favorite Button State

        let isFavorite =
        presenter?.isFavorite(
            league: league
        ) ?? false

        cell.configureFavoriteButton(
            isFavorite: isFavorite
        )

        // MARK: - Favorite Action

        cell.favoriteButtonAction = { [weak self] in

            guard let self = self else {
                return
            }

            let isFavorite =
            self.presenter?.isFavorite(
                league: league
            ) ?? false

            
            // MARK: - Already Favorite -> Show Delete Alert

            if isFavorite {

                let alert = UIAlertController(
                    title: "Remove Favorite",
                    message: "Are you sure you want to remove this league from favorites?",
                    preferredStyle: .alert
                )

                let deleteAction = UIAlertAction(
                    title: "Remove",
                    style: .destructive
                ) { _ in

                    self.presenter?.toggleFavorite(
                        league: league,
                        sport: self.selectedSport ?? ""
                    )

                    tableView.reloadRows(
                        at: [indexPath],
                        with: .automatic
                    )
                }

                let cancelAction = UIAlertAction(
                    title: "Cancel",
                    style: .cancel
                )

                alert.addAction(deleteAction)
                alert.addAction(cancelAction)

                self.present(alert, animated: true)

            } else {

                // MARK: - Add Directly

                self.presenter?.toggleFavorite(
                    league: league,
                    sport: self.selectedSport ?? ""
                )

                tableView.reloadRows(
                    at: [indexPath],
                    with: .automatic
                )

                let alert = UIAlertController(
                    title: "Added To Favorites",
                    message: "League added successfully.",
                    preferredStyle: .alert
                )

                alert.addAction(
                    UIAlertAction(
                        title: "OK",
                        style: .default
                    )
                )

                self.present(alert, animated: true)
            }
        }

        return cell
    }
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        
        if !NetworkMonitor.shared.checkConnection() {
                self.showError(message: "Internet connection is required to view league details.")
                return
            }

        guard let selectedLeague =
                presenter?.getLeague(at: indexPath.row)
        else {
            return
        }

        let storyboard = UIStoryboard(
            name: "Main",
            bundle: nil
        )

        let detailsVC =
        storyboard.instantiateViewController(
            withIdentifier: "LeagueDetailsViewController"
        ) as! LeagueDetailsViewController

        
        // PASS LEAGUE ID
        
        detailsVC.leagueID =
        selectedLeague.leagueKey ?? 0

        detailsVC.league =
        selectedLeague

        
        navigationController?.pushViewController(
            detailsVC,
            animated: true
        )
    }
}
