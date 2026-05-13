//
//  LeaguesTableViewCell.swift
//  Active
//
//  Created by Yomna on 07/05/2026.
//

import UIKit

class LeaguesTableViewCell: UITableViewCell {

   
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var leagueNameLabel: UILabel!
    @IBOutlet weak var leagueImageView: UIImageView!
    var favoriteButtonAction: (() -> Void)?
    private var isFavorite = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = .clear
    }
  
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        favoriteButtonAction?()
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

        leagueImageView.layer.cornerRadius =
        leagueImageView.frame.width / 2

        leagueImageView.clipsToBounds = true
    }
    override func setSelected(
           _ selected: Bool,
           animated: Bool
       ) {

           super.setSelected(
               selected,
               animated: animated
           )
       }
    
    func configureFavoriteButton(
        isFavorite: Bool
    ) {

        self.isFavorite = isFavorite

        let imageName =
        isFavorite ? "heart.fill" : "heart"

        favoriteButton.setImage(
            UIImage(systemName: imageName),
            for: .normal
        )

        favoriteButton.tintColor = .systemRed
    }
}
