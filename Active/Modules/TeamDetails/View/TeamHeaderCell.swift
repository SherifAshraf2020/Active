//
//  TeamHeaderCell.swift
//  Active
//
//  Created by Sherif Ashraf Farooq  on 11/05/2026.
//

import UIKit
import Kingfisher

class TeamHeaderCell: UITableViewCell {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var venueLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with team: TDTeam) {
        nameLabel.text = team.team_name
        venueLabel.text = "🏟️ \(team.venue_name ?? "Unknown Stadium")"
        if let url = URL(string: team.team_logo ?? "") {
            logoImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "sportscourt"))
        }
    }
}
