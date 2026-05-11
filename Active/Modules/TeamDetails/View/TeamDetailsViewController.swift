//
//  TeamDetailsViewController.swift
//  Active
//
//  Created by Sherif Ashraf Farooq  on 11/05/2026.
//

import UIKit

class TeamDetailsViewController: UIViewController {

    var presenter: TeamDetailsPresenter!
    var teamData: TDTeam?
    
    enum Sections: Int, CaseIterable {
        case header = 0, coach, squad, lastResults, upcomingMatches
        var title: String? {
            switch self {
            case .header: return nil
            case .coach: return "Coach"
            case .squad: return "Squad List"
            case .lastResults: return "Last Results"
            case .upcomingMatches: return "Upcoming Matches"
            }
        }
    }

    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(TeamHeaderCell.self, forCellReuseIdentifier: "TeamHeaderCell")
        table.register(UITableViewCell.self, forCellReuseIdentifier: "CoachCell")
        table.register(PlayerCell.self, forCellReuseIdentifier: "PlayerCell")
        table.register(MatchCell.self, forCellReuseIdentifier: "MatchCell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.getTeamDetails()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Team Details"
        view.addSubview(tableView)
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - TeamDetailsViewProtocol Implementation
extension TeamDetailsViewController: TeamDetailsViewProtocol {
    
    func showLoading() {
        print("🔄 Loading Team Data...")
    }
    
    func hideLoading() {
        print("✅ Loading Finished.")
    }
    
    func displayTeamDetails(team: TDTeam) {
        self.teamData = team
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showError(message: String) {
        print("❌ Error: \(message)")
    }
}

// MARK: - UITableViewDataSource
extension TeamDetailsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Sections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let team = teamData else { return 0 }
        
        switch Sections(rawValue: section) {
        case .header: return 1
        case .coach: return team.coaches?.count ?? 0
        case .squad: return team.players?.count ?? 0
        case .lastResults:
            return min(team.lastMatches?.count ?? 0, 3)
        case .upcomingMatches:
            return min(team.nextMatches?.count ?? 0, 5) 
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Sections(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        case .header:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TeamHeaderCell", for: indexPath) as! TeamHeaderCell
            if let team = teamData { cell.configure(with: team) }
            return cell
            
        case .coach:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CoachCell", for: indexPath)
            cell.textLabel?.text = teamData?.coaches?[indexPath.row].coach_name
            cell.imageView?.image = UIImage(systemName: "person.circle.fill")
            return cell
            
        case .squad:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! PlayerCell
            if let player = teamData?.players?[indexPath.row] { cell.configure(with: player) }
            return cell
            
        case .lastResults:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MatchCell", for: indexPath) as! MatchCell
            if let match = teamData?.lastMatches?[indexPath.row] {
                let home = match.event_home_team ?? ""
                let away = match.event_away_team ?? ""
                let result = match.event_final_result ?? ""
                cell.configure(with: "\(home) \(result) \(away)")
            }
            return cell
            
        case .upcomingMatches:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MatchCell", for: indexPath) as! MatchCell
            // تعديل السطر ده لاستخدام nextMatches
            if let match = teamData?.nextMatches?[indexPath.row] {
                let home = match.event_home_team ?? ""
                let away = match.event_away_team ?? ""
                let date = match.event_date ?? ""
                cell.configure(with: "\(home) vs \(away)\n📅 \(date)")
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Sections(rawValue: section)?.title
    }
}
