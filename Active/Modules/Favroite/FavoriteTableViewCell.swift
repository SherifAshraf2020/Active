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
    
    
    var deleteHandler: (() -> Void)?
    
    @IBAction func favButton(_ sender: UIButton) {
        deleteHandler?()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        leagueLogo.layer.cornerRadius = leagueLogo.frame.height / 2
        leagueLogo.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
