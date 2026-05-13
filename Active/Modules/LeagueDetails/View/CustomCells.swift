//
//  CustomCells.swift
//  Active
//
//  Created by Yomna on 10/05/2026.
//

import UIKit
import Kingfisher

// MARK: - Upcoming Event Cell

class UpcomingEventCell: UICollectionViewCell {

    // MARK: - UI Components

    private let eventNameLabel = UILabel()

    private let dateLabel = UILabel()

    private let timeLabel = UILabel()

    private let homeImageView = UIImageView()

    private let awayImageView = UIImageView()


    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Setup UI

extension UpcomingEventCell {

    private func setupUI() {

        contentView.backgroundColor = .systemGray6

        contentView.layer.cornerRadius = 16


        // MARK: Event Name

        eventNameLabel.font = .boldSystemFont(ofSize: 18)

        eventNameLabel.textAlignment = .center

        eventNameLabel.numberOfLines = 2


        // MARK: Date

        dateLabel.font = .systemFont(ofSize: 16)

        dateLabel.textAlignment = .center


        // MARK: Time

        timeLabel.font = .systemFont(ofSize: 16)

        timeLabel.textAlignment = .center


        // MARK: Images

        homeImageView.contentMode = .scaleAspectFit

        awayImageView.contentMode = .scaleAspectFit


        // MARK: Images Stack

        let imagesStack = UIStackView(
            arrangedSubviews: [
                homeImageView,
                awayImageView
            ]
        )

        imagesStack.axis = .horizontal

        imagesStack.distribution = .fillEqually

        imagesStack.spacing = 16


        // MARK: Main Stack

        let mainStack = UIStackView(
            arrangedSubviews: [
                eventNameLabel,
                dateLabel,
                timeLabel,
                imagesStack
            ]
        )

        mainStack.axis = .vertical

        mainStack.spacing = 16


        contentView.addSubview(mainStack)

        mainStack.translatesAutoresizingMaskIntoConstraints = false


        NSLayoutConstraint.activate([

            mainStack.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 16
            ),

            mainStack.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16
            ),

            mainStack.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -16
            ),

            mainStack.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -16
            ),

            homeImageView.heightAnchor.constraint(
                equalToConstant: 80
            ),

            awayImageView.heightAnchor.constraint(
                equalToConstant: 80
            )
        ])
    }
}


// MARK: - Configure

extension UpcomingEventCell {

    func configure(event: Event) {

        eventNameLabel.text =
        "\(event.event_home_team ?? "") VS \(event.event_away_team ?? "")"

        dateLabel.text = event.event_date

        timeLabel.text = event.event_time


        homeImageView.kf.setImage(
            with: URL(string: event.home_team_logo ?? "")
        )

        awayImageView.kf.setImage(
            with: URL(string: event.away_team_logo ?? "")
        )
    }
}


// MARK: - Latest Event Cell

class LatestEventCell: UICollectionViewCell {

    // MARK: - UI Components

    private let teamsLabel = UILabel()

    private let scoreLabel = UILabel()

    private let dateLabel = UILabel()

    private let timeLabel = UILabel()

    private let homeImageView = UIImageView()

    private let awayImageView = UIImageView()


    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Setup UI

extension LatestEventCell {

    private func setupUI() {

        contentView.backgroundColor = .systemGray6

        contentView.layer.cornerRadius = 20

        contentView.layer.shadowColor = UIColor.black.cgColor

        contentView.layer.shadowOpacity = 0.1

        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)

        contentView.layer.shadowRadius = 4


        // MARK: Teams Label

        teamsLabel.font = .boldSystemFont(ofSize: 22)

        teamsLabel.textAlignment = .center

        teamsLabel.numberOfLines = 2


        // MARK: Score Label

        scoreLabel.font = .boldSystemFont(ofSize: 30)

        scoreLabel.textAlignment = .center

        scoreLabel.textColor = .systemBlue


        // MARK: Date & Time

        dateLabel.font = .systemFont(ofSize: 14)

        dateLabel.textAlignment = .center

        dateLabel.textColor = .secondaryLabel


        timeLabel.font = .systemFont(ofSize: 14)

        timeLabel.textAlignment = .center

        timeLabel.textColor = .secondaryLabel


        // MARK: Images

        homeImageView.contentMode = .scaleAspectFit

        awayImageView.contentMode = .scaleAspectFit


        // MARK: Images Stack

        let imagesStack = UIStackView(
            arrangedSubviews: [
                homeImageView,
                awayImageView
            ]
        )

        imagesStack.axis = .horizontal

        imagesStack.distribution = .fillEqually

        imagesStack.spacing = 24


        // MARK: Main Stack

        let mainStack = UIStackView(
            arrangedSubviews: [
                teamsLabel,
                scoreLabel,
                dateLabel,
                timeLabel,
                imagesStack
            ]
        )

        mainStack.axis = .vertical

        mainStack.spacing = 8


        contentView.addSubview(mainStack)

        mainStack.translatesAutoresizingMaskIntoConstraints = false


        NSLayoutConstraint.activate([

            mainStack.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 16
            ),

            mainStack.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16
            ),

            mainStack.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -16
            ),

            mainStack.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -16
            ),

            homeImageView.heightAnchor.constraint(
                equalToConstant: 80
            ),

            awayImageView.heightAnchor.constraint(
                equalToConstant: 80
            )
        ])
    }
}


// MARK: - Configure

extension LatestEventCell {

    func configure(event: Event) {

        teamsLabel.text =
        "\(event.event_home_team ?? "") VS \(event.event_away_team ?? "")"

        scoreLabel.text =
        event.event_final_result ?? "VS"

        dateLabel.text = event.event_date

        timeLabel.text = event.event_time

        homeImageView.kf.setImage(
            with: URL(string: event.home_team_logo ?? ""),
            placeholder: UIImage(systemName: "sportscourt")
        )

        awayImageView.kf.setImage(
            with: URL(string: event.away_team_logo ?? ""),
            placeholder: UIImage(systemName: "sportscourt")
        )
    }
}

// MARK: - Team Cell

class TeamCell: UICollectionViewCell {

    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let favoriteButton = UIButton(type: .system)
    
    var onFavoriteTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func favTapped() {
        onFavoriteTapped?()
    }
}

extension TeamCell {

    private func setupUI() {
        contentView.backgroundColor = .clear

        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        nameLabel.font = .boldSystemFont(ofSize: 12)
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 2
        favoriteButton.addTarget(self, action: #selector(favTapped), for: .touchUpInside)
        favoriteButton.tintColor = .systemRed

        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(favoriteButton)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80),

            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),

            favoriteButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: -4),
            favoriteButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 4),
            favoriteButton.widthAnchor.constraint(equalToConstant: 28),
            favoriteButton.heightAnchor.constraint(equalToConstant: 28)
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = imageView.frame.width / 2
    }

    func configure(team: Team, isFav: Bool) {
        nameLabel.text = team.team_name
        imageView.kf.setImage(with: URL(string: team.team_logo ?? ""), placeholder: UIImage(systemName: "sportscourt"))
        
        let heartIcon = isFav ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        favoriteButton.setImage(heartIcon, for: .normal)
    }
}
