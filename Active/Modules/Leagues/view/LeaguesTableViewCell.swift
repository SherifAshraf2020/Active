//
//  LeaguesTableViewCell.swift
//  Active
//
//  Created by Yomna on 07/05/2026.
//

import UIKit

class LeaguesTableViewCell: UITableViewCell {

   
    @IBOutlet weak var leagueNameLabel: UILabel!
    @IBOutlet weak var leagueImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
          super.layoutSubviews()

          leagueImageView.layer.cornerRadius =
          leagueImageView.frame.width / 2

          leagueImageView.clipsToBounds = true
      }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
