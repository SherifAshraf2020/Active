//
//  FavoritesViewController.swift
//  Active
//
//  Created by Sherif Ashraf Farooq  on 07/05/2026.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var favoritesTableView: UITableView!
    override func viewDidLoad() {
            super.viewDidLoad()
            favoritesTableView.delegate = self
            favoritesTableView.dataSource = self
        }

    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 5
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoriteTableViewCell
            cell.leagueName?.text = "League Name"
            return cell
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
