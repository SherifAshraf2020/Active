//
//  SportsCollectionViewCell.swift
//  Active
//
//  Created by Sherif Ashraf Farooq  on 06/05/2026.
//

import UIKit

class SportsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var sportImageView: UIImageView!
    @IBOutlet weak var sportLabel: UILabel!
    
    
    override func awakeFromNib() {
            super.awakeFromNib()
            
        self.contentView.backgroundColor = .darkGray
            self.contentView.layer.cornerRadius = 15
            self.contentView.clipsToBounds = true
            sportLabel.textColor = .white
            sportLabel.font = UIFont.boldSystemFont(ofSize: 18)
        }
}
