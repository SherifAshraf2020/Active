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

    private let gradientView = UIView()

    override func awakeFromNib() {
        super.awakeFromNib()

        setupCell()
    }

    private func setupCell() {

        // Cell style
        contentView.layer.cornerRadius = 24
        contentView.clipsToBounds = true

        layer.shadowColor = UIColor.systemGray.cgColor
        layer.shadowOpacity = 0.05
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowRadius = 6
        layer.masksToBounds = false

        // Image
        sportImageView.contentMode = .scaleAspectFill
        sportImageView.clipsToBounds = true

        // Label
        sportLabel.textColor = .white
        sportLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)

        sportLabel.layer.shadowColor = UIColor.black.cgColor
        sportLabel.layer.shadowOpacity = 0.2
        sportLabel.layer.shadowRadius = 4

    }

    func configure(with sport: Sport) {

        sportLabel.text = sport.strSport

        // Image
        if let image = UIImage(named: sport.strSportThumb) {

            sportImageView.image = image

        } else {

            sportImageView.image = UIImage(named: "placeholder")
        }

        // Background color behind image
        switch sport.strSport.lowercased() {

        case "football":
            contentView.backgroundColor = UIColor.systemGreen

        case "basketball":
            contentView.backgroundColor = UIColor.systemOrange

        case "tennis":
            contentView.backgroundColor = UIColor.systemBlue

        case "cricket":
            contentView.backgroundColor = UIColor.systemPurple

        default:
            contentView.backgroundColor = UIColor.darkGray
        }
    }
}
