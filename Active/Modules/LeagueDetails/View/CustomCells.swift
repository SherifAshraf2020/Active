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

    private let dateTimeLabel = UILabel()

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

        contentView.layer.cornerRadius = 18

        contentView.layer.shadowColor = UIColor.black.cgColor

        contentView.layer.shadowOpacity = 0.08

        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)

        contentView.layer.shadowRadius = 4


        // MARK: Event Name

        eventNameLabel.font = .systemFont(
            ofSize: 18,
            weight: .semibold
        )

        eventNameLabel.textAlignment = .center

        eventNameLabel.numberOfLines = 2

        eventNameLabel.lineBreakMode = .byTruncatingTail


        // MARK: Date & Time

        dateTimeLabel.font = .systemFont(
            ofSize: 13,
            weight: .medium
        )

        dateTimeLabel.textAlignment = .center

        dateTimeLabel.textColor = .secondaryLabel


        // MARK: Images

        homeImageView.contentMode = .scaleAspectFit

        awayImageView.contentMode = .scaleAspectFit


        // MARK: Logos Stack

        let logosStack = UIStackView(
            arrangedSubviews: [
                homeImageView,
                awayImageView
            ]
        )

        logosStack.axis = .horizontal

        logosStack.alignment = .center

        logosStack.distribution = .fill

        logosStack.spacing = 40

        logosStack.layoutMargins = UIEdgeInsets(
            top: 0,
            left: 12,
            bottom: 0,
            right: 12
        )

        logosStack.isLayoutMarginsRelativeArrangement = true


        // MARK: Main Stack

        let mainStack = UIStackView(
            arrangedSubviews: [
                eventNameLabel,
                dateTimeLabel,
                logosStack
            ]
        )

        mainStack.axis = .vertical

        mainStack.spacing = 6


        contentView.addSubview(mainStack)

        mainStack.translatesAutoresizingMaskIntoConstraints = false


        NSLayoutConstraint.activate([

            mainStack.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 14
            ),

            mainStack.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 14
            ),

            mainStack.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -14
            ),

            mainStack.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -14
            ),


            // MARK: Logo Sizes

            homeImageView.widthAnchor.constraint(
                equalToConstant: 68
            ),

            homeImageView.heightAnchor.constraint(
                equalToConstant: 68
            ),

            awayImageView.widthAnchor.constraint(
                equalToConstant: 68
            ),

            awayImageView.heightAnchor.constraint(
                equalToConstant: 68
            )
        ])
    }
}


// MARK: - Configure

extension UpcomingEventCell {

    func configure(event: Event) {

        eventNameLabel.text =
        "\(event.event_home_team ?? "") VS \(event.event_away_team ?? "")"

        dateTimeLabel.text =
        "\(event.event_date ?? "") • \(event.event_time ?? "")"


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

    private let infoLabel = UILabel()

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

        contentView.layer.shadowOpacity = 0.08

        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)

        contentView.layer.shadowRadius = 4


        // MARK: Teams Label

        teamsLabel.font = .systemFont(
            ofSize: 16,
            weight: .semibold
        )

        teamsLabel.textAlignment = .center

        teamsLabel.numberOfLines = 2

        teamsLabel.lineBreakMode = .byTruncatingTail


        // MARK: Score Label

        scoreLabel.font = .boldSystemFont(ofSize: 24)

        scoreLabel.textAlignment = .center

        scoreLabel.textColor = .systemBlue


        // MARK: Date & Time Label

        infoLabel.font = .systemFont(
            ofSize: 11,
            weight: .medium
        )

        infoLabel.textAlignment = .center

        infoLabel.textColor = .secondaryLabel


        // MARK: Images

        homeImageView.contentMode = .scaleAspectFit

        awayImageView.contentMode = .scaleAspectFit


        // MARK: Match Stack

        let matchStack = UIStackView(
            arrangedSubviews: [
                homeImageView,
                scoreLabel,
                awayImageView
            ]
        )

        matchStack.axis = .horizontal

        matchStack.alignment = .center

        matchStack.distribution = .fill

        matchStack.spacing = 24


        // MARK: Main Stack

        let mainStack = UIStackView(
            arrangedSubviews: [
                teamsLabel,
                infoLabel,
                matchStack
            ]
        )

        mainStack.axis = .vertical

        mainStack.alignment = .fill

        mainStack.spacing = 2


        contentView.addSubview(mainStack)

        mainStack.translatesAutoresizingMaskIntoConstraints = false


        NSLayoutConstraint.activate([

            mainStack.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 10
            ),

            mainStack.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 10
            ),

            mainStack.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -10
            ),

            mainStack.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -10
            ),


            // MARK: Logo Sizes

            homeImageView.widthAnchor.constraint(
                equalToConstant: 60
            ),

            homeImageView.heightAnchor.constraint(
                equalToConstant: 60
            ),

            awayImageView.widthAnchor.constraint(
                equalToConstant: 60
            ),

            awayImageView.heightAnchor.constraint(
                equalToConstant: 60
            ),
           
        ])
        scoreLabel.setContentHuggingPriority(
            .required,
            for: .horizontal
        )

        scoreLabel.setContentCompressionResistancePriority(
            .required,
            for: .horizontal
        )
    }
}


// MARK: - Configure

extension LatestEventCell {

    func configure(event: Event) {

        teamsLabel.text =
        "\(event.event_home_team ?? "") VS \(event.event_away_team ?? "")"

        scoreLabel.text =
        event.event_final_result ?? "VS"

        infoLabel.text =
            "\(event.event_date ?? "") • \(event.event_time ?? "")"

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
