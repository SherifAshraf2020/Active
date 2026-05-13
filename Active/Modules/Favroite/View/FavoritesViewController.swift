//
//  FavoritesViewController.swift
//  Active
//
//  Created by Sherif Ashraf Farooq  on 07/05/2026.
//

import UIKit
import Kingfisher

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FavoritesViewProtocol {

    @IBOutlet weak var favoritesTableView: UITableView!
    @IBOutlet weak var favoriteSegmentControl: UISegmentedControl!
    
    var favoriteLeagues: [League] = []
    var favoriteTeams: [TeamEntity] = []
    var isLeagueView = true
    var presenter: FavoritesPresenter!

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEmptyStateUI()
        presenter = FavoritesPresenter(view: self)
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getFavorites()
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        presenter.currentSegmentIndex = sender.selectedSegmentIndex
        isLeagueView = (sender.selectedSegmentIndex == 0)
        presenter.getFavorites()
    }
    
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isLeagueView ? favoriteLeagues.count : favoriteTeams.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoriteTableViewCell
        
        if isLeagueView {
            let league = favoriteLeagues[indexPath.row]
            cell.leagueName?.text = league.league_name
            
            if let logoString = league.league_logo, let url = URL(string: logoString) {
                cell.leagueLogo.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
            } else {
                cell.leagueLogo.image = UIImage(named: "placeholder")
            }

            cell.deleteHandler = { [weak self] in
                guard let self = self else { return }
                let alert = UIAlertController(
                    title: "Remove Favorite",
                    message: "Are you sure you want to remove this league from favorites?",
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { _ in
                    self.presenter.deleteLeague(league: league)
                })
                self.present(alert, animated: true)
            }
        } else {
            let team = favoriteTeams[indexPath.row]
            cell.leagueName?.text = team.team_name
            
            if let logoString = team.team_logo, let url = URL(string: logoString) {
                cell.leagueLogo.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
            } else {
                cell.leagueLogo.image = UIImage(named: "placeholder")
            }

            cell.deleteHandler = { [weak self] in
                guard let self = self else { return }
                let alert = UIAlertController(
                    title: "Remove Favorite",
                    message: "Are you sure you want to remove this team from favorites?",
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { _ in
                    self.presenter.deleteTeam(team: team)
                })
                self.present(alert, animated: true)
            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !NetworkMonitor.shared.checkConnection() {
            let alert = UIAlertController(
                title: "No Internet",
                message: "Internet connection is required to open details.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }

        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        if isLeagueView {
            let league = favoriteLeagues[indexPath.row]
            let detailsVC = storyboard.instantiateViewController(withIdentifier: "LeagueDetailsViewController") as! LeagueDetailsViewController
            detailsVC.leagueID = Int(league.league_key ?? "") ?? 0
            navigationController?.pushViewController(detailsVC, animated: true)
        } else {
            let teamEntity = favoriteTeams[indexPath.row]
            let teamDetailsVC = storyboard.instantiateViewController(withIdentifier: "TeamDetailsViewController") as! TeamDetailsViewController
            
            let team = Team(
                team_key: Int(teamEntity.team_key),
                team_name: teamEntity.team_name,
                team_logo: teamEntity.team_logo
            )
            
            teamDetailsVC.team = team
            navigationController?.pushViewController(teamDetailsVC, animated: true)
        }
    }
}
