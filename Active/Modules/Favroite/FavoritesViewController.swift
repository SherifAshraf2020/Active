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

        override func viewDidLoad() {
            super.viewDidLoad()
            
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

        func showFavoriteLeagues(_ leagues: [League]) {
            self.favoriteLeagues = leagues
            self.favoritesTableView.isHidden = false
            self.favoritesTableView.reloadData()
        }

        func showEmptyState() {
            self.favoriteLeagues = []
            self.favoritesTableView.isHidden = true
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
