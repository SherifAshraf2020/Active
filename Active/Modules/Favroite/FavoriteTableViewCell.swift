//
//  FavoriteTableViewCell.swift
//  Active
//
//  Created by Sherif Ashraf Farooq  on 08/05/2026.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var leagueLogo: UIImageView!
    @IBOutlet weak var leagueName: UILabel!
    
    @IBAction func favButton(_ sender: UIButton) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
