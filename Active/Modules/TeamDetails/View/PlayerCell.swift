//
//  PlayerCell.swift
//  Active
//
//  Created by Sherif Ashraf Farooq  on 11/05/2026.
//

import UIKit

class PlayerCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!

    func configure(with player: TDPlayer) {
        nameLabel.text = player.player_name
        positionLabel.text = player.player_type
        numberLabel.text = player.player_number
    }
}
