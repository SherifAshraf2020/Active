//
//  FavoritesViewController.swift
//  Active
//
//  Created by Sherif Ashraf Farooq  on 07/05/2026.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FavoritesViewProtocol {

    @IBOutlet weak var favoritesTableView: UITableView!
    
    var favoriteLeagues: [League] = []
    var presenter: FavoritesPresenter!

    // MARK: - Empty State UI
        let noDataView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.isHidden = true
            return view
        }()

        let messageLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "No Favorites yet!\nStart adding your favorite leagues."
            label.numberOfLines = 0
            label.textAlignment = .center
            label.textColor = .systemGray
            label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
            return label
        }()
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            setupEmptyStateUI()
            
            presenter = FavoritesPresenter(view: self)
            
            favoritesTableView.delegate = self
            favoritesTableView.dataSource = self
            
            if CoreDataManager.shared.fetchFavorites().isEmpty {
                CoreDataManager.shared.saveLeague(key: "1", name: "Premier League", logo: "premier_logo", sport: "Football")
                CoreDataManager.shared.saveLeague(key: "2", name: "La Liga", logo: "laliga_logo", sport: "Football")
                CoreDataManager.shared.saveLeague(key: "3", name: "Serie A", logo: "seriea_logo", sport: "Football")
            }
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            presenter.getFavorites()
        }
    
    
    // MARK: - Setup Empty State
        private func setupEmptyStateUI() {
        view.addSubview(noDataView)
        noDataView.addSubview(messageLabel)
            
        NSLayoutConstraint.activate([
            noDataView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noDataView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noDataView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            noDataView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
                
            messageLabel.topAnchor.constraint(equalTo: noDataView.topAnchor),
            messageLabel.bottomAnchor.constraint(equalTo: noDataView.bottomAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: noDataView.leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: noDataView.trailingAnchor)
            ])
        }

        func showFavoriteLeagues(_ leagues: [League]) {
            self.favoriteLeagues = leagues
            self.favoritesTableView.isHidden = false
            self.noDataView.isHidden = true
            self.favoritesTableView.reloadData()
        }

        func showEmptyState() {
            self.favoriteLeagues = []
            self.favoritesTableView.isHidden = true
            self.noDataView.isHidden = false
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return favoriteLeagues.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoriteTableViewCell
            
            if indexPath.row < favoriteLeagues.count {
                let league = favoriteLeagues[indexPath.row]
                cell.leagueName?.text = league.league_name
                
                cell.deleteHandler = { [weak self] in
                    self?.presenter.deleteFromFavorites(league: league)
                }
            }
            return cell
        }
    }
