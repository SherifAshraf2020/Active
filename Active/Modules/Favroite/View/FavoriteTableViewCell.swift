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

    override func layoutSubviews() {
        super.layoutSubviews()

        backgroundColor = .clear

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(
            top: 8,
            left: 16,
            bottom: 8,
            right: 16
        ))

        contentView.layer.cornerRadius = 18
        contentView.layer.masksToBounds = true

        layer.masksToBounds = false

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.15
        layer.shadowRadius = 6
        layer.shadowOffset = CGSize(width: 0, height: 3)

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
