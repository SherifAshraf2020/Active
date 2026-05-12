//
//  FavoritesViewController.swift
//  Active
//
//  Created by Sherif Ashraf Farooq  on 07/05/2026.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FavoritesViewProtocol {

    // MARK: - Outlets
    @IBOutlet weak var favoritesTableView: UITableView!
    @IBOutlet weak var favoriteSegmentControl: UISegmentedControl!
    
    // MARK: - Properties
    var favoriteLeagues: [League] = []
    var favoriteTeams: [TeamEntity] = []
    var isLeagueView = true
    var presenter: FavoritesPresenter!

    // MARK: - Empty State UI Components
    let noDataView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()

    let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No Favorites yet!\nStart adding your favorites."
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEmptyStateUI()
        presenter = FavoritesPresenter(view: self)
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        
        // Mock Data for testing
        if CoreDataManager.shared.fetchFavorites().isEmpty && CoreDataManager.shared.fetchFavoriteTeams().isEmpty {
                    
                    CoreDataManager.shared.saveLeague(key: "1", name: "Premier League", logo: "premier_logo", sport: "Football")
                    CoreDataManager.shared.saveLeague(key: "2", name: "La Liga", logo: "laliga_logo", sport: "Football")
                    CoreDataManager.shared.saveLeague(key: "3", name: "Champions League", logo: "ucl_logo", sport: "Football")
                    
                    CoreDataManager.shared.saveTeam(key: 101, name: "Real Madrid", logo: "madrid_logo", sport: "Football")
                    CoreDataManager.shared.saveTeam(key: 102, name: "Liverpool", logo: "lfc_logo", sport: "Football")
                    CoreDataManager.shared.saveTeam(key: 103, name: "Al Ahly SC", logo: "ahly_logo", sport: "Football")
                    
                    print("✅ Static Mock Data added successfully!")
                }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getFavorites()
    }
    
    // MARK: - Actions
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        presenter.currentSegmentIndex = sender.selectedSegmentIndex
        isLeagueView = (sender.selectedSegmentIndex == 0)
        presenter.getFavorites()
    }
    
    // MARK: - UI Setup
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

    // MARK: - Protocol Implementation
    func showFavorites(leagues: [League]?, teams: [TeamEntity]?, isLeague: Bool) {
        self.isLeagueView = isLeague
        if isLeague {
            self.favoriteLeagues = leagues ?? []
            self.favoriteTeams = []
        } else {
            self.favoriteTeams = teams ?? []
            self.favoriteLeagues = []
        }
        self.favoritesTableView.isHidden = false
        self.noDataView.isHidden = true
        self.favoritesTableView.reloadData()
    }

    func showEmptyState() {
        self.favoriteLeagues = []
        self.favoriteTeams = []
        self.favoritesTableView.isHidden = true
        self.noDataView.isHidden = false
    }

    // MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isLeagueView ? favoriteLeagues.count : favoriteTeams.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoriteTableViewCell
        
        if isLeagueView {
            let league = favoriteLeagues[indexPath.row]
            cell.leagueName?.text = league.league_name
            cell.deleteHandler = { [weak self] in
                self?.presenter.deleteLeague(league: league)
            }
        } else {
            let team = favoriteTeams[indexPath.row]
            cell.leagueName?.text = team.team_name
            cell.deleteHandler = { [weak self] in
                self?.presenter.deleteTeam(team: team)
            }
        }
        return cell
    }
}
