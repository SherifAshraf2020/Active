//
//  FavoritesViewController.swift
//  Active
//
//  Created by Sherif Ashraf Farooq  on 07/05/2026.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var favoritesTableView: UITableView!
    
    var favoriteLeagues: [League] = []
    
    override func viewDidLoad() {
            super.viewDidLoad()
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
            favoriteLeagues = CoreDataManager.shared.fetchFavorites()
            favoritesTableView.reloadData()
        }
    
    
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return favoriteLeagues.count
        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoriteTableViewCell
            
            let league = favoriteLeagues[indexPath.row]
            cell.leagueName?.text = league.league_name
            
            cell.deleteHandler = { [weak self] in
                self?.handleDeleteAction(at: indexPath)
            }
            
            return cell
        }
    
    
    func handleDeleteAction(at indexPath: IndexPath) {
            let leagueToDelete = favoriteLeagues[indexPath.row]
            CoreDataManager.shared.deleteLeague(league: leagueToDelete)
            favoriteLeagues.remove(at: indexPath.row)
            favoritesTableView.deleteRows(at: [indexPath], with: .fade)
        }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
