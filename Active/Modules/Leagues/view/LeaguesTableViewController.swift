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

    var sportName: String = "football"

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Leagues"

        tableView.rowHeight = 90

        presenter = LeaguesPresenter()

        presenter?.attachView(self)

        presenter?.getLeagues(for: sportName)
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
            title: "Error",
            message: message,
            preferredStyle: .alert
        )

        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: .default
            )
        )

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

        let league =
        presenter?.getLeague(at: indexPath.row)

        cell.leagueNameLabel.text =
        league?.leagueName

        if let imageString = league?.leagueLogo,
           let url = URL(string: imageString) {

            cell.leagueImageView.kf.setImage(
                with: url
            )
        }

        return cell
    }
}
