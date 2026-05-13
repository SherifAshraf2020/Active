//
//  LeagueDetailsViewController.swift
//  Active
//
//  Created by Yomna on 10/05/2026.
//

import UIKit
import Foundation

protocol LeagueDetailsViewProtocol: AnyObject {
    
    func reloadData()
    
    func showError(message: String)
    
    func startLoading()

    func stopLoading()
}

class LeagueDetailsViewController: UIViewController {

    
    // MARK: - Outlet
    
    @IBOutlet weak var collectionView: UICollectionView!
    private let favoriteButton = UIButton(type: .system)
    
    
    // MARK: - Properties
    
    var presenter: LeagueDetailsPresenterProtocol!
    
    var leagueID: Int = 152
    
    var league: LeagueModel?
    
    let indicator = UIActivityIndicatorView(style: .large)
    
    private let emptyLabel: UILabel = {

        let label = UILabel()

        label.text = "No Data Available"

        label.textAlignment = .center

        label.font = .systemFont(
            ofSize: 22,
            weight: .semibold
        )

        label.textColor = .secondaryLabel

        label.isHidden = true

        return label
    }()
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = LeagueDetailsPresenter(
            view: self,
            leagueID: leagueID
        )
        
        setupCollectionView()
        setupFavoriteButton()
        
        presenter.viewDidLoad()
        view.addSubview(emptyLabel)

        emptyLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            emptyLabel.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),

            emptyLabel.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            )
        ])
    }
}


// MARK: - Setup CollectionView

extension LeagueDetailsViewController {
    
    private func setupCollectionView() {
        
        collectionView.delegate = self
        
        collectionView.dataSource = self
        
        collectionView.collectionViewLayout = createLayout()
        
        collectionView.backgroundColor = .systemBackground
        
        
        // MARK: Register Cells
        
        collectionView.register(
            UpcomingEventCell.self,
            forCellWithReuseIdentifier: "UpcomingEventCell"
        )
        
        collectionView.register(
            LatestEventCell.self,
            forCellWithReuseIdentifier: "LatestEventCell"
        )
        
        collectionView.register(
            TeamCell.self,
            forCellWithReuseIdentifier: "TeamCell"
        )
    }
    
}

// MARK: - Floating Favorite Button

extension LeagueDetailsViewController {

    private func setupFavoriteButton() {

        view.addSubview(favoriteButton)

        favoriteButton.translatesAutoresizingMaskIntoConstraints = false

        favoriteButton.tintColor = .white

        favoriteButton.backgroundColor = .systemRed

        favoriteButton.layer.cornerRadius = 30

        favoriteButton.layer.shadowColor =
        UIColor.black.cgColor

        favoriteButton.layer.shadowOpacity = 0.3

        favoriteButton.layer.shadowOffset =
        CGSize(width: 0, height: 4)

        favoriteButton.layer.shadowRadius = 6

        favoriteButton.addTarget(
            self,
            action: #selector(favoriteButtonTapped),
            for: .touchUpInside
        )

        NSLayoutConstraint.activate([

            favoriteButton.widthAnchor.constraint(
                equalToConstant: 60
            ),

            favoriteButton.heightAnchor.constraint(
                equalToConstant: 60
            ),

            favoriteButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24
            ),

            favoriteButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -24
            )
        ])

        updateFavoriteButton()
    }


    // MARK: - Update Favorite Button

    private func updateFavoriteButton() {

        guard let league = league else {
            return
        }

        let isFavorite =
        presenter.isFavorite(
            league: league
        )

        let imageName =
        isFavorite ? "heart.fill" : "heart"

        let image = UIImage(
            systemName: imageName
        )?.withTintColor(
            .white,
            renderingMode: .alwaysOriginal
        )

        favoriteButton.setImage(
            image,
            for: .normal
        )
    }


    // MARK: - Favorite Action

    @objc private func favoriteButtonTapped() {

        guard let league = league else {
            return
        }

        let isFavorite =
        presenter.isFavorite(
            league: league
        )

        presenter.toggleFavorite(
            league: league
        )

        updateFavoriteButton()

        let message =
        isFavorite
        ? "League Removed Successfully"
        : "League Added Successfully"

        let alert = UIAlertController(
            title: "Favorites",
            message: message,
            preferredStyle: .alert
        )

        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: .default
            )
        )

        present(alert, animated: true)
    }
}


// MARK: - Compositional Layout

extension LeagueDetailsViewController {
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        
        UICollectionViewCompositionalLayout {
            sectionIndex,
            environment in
            
            let section = Section(
                rawValue: sectionIndex
            )
            
            switch section {
                
            case .upcoming:
                return self.createUpcomingSection()
                
            case .latest:
                return self.createLatestSection()
                
            case .teams:
                return self.createTeamsSection()
                
            default:
                return self.createUpcomingSection()
            }
        }
    }
}


// MARK: - Upcoming Section
extension LeagueDetailsViewController {

    private func createUpcomingSection()
    -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )

        let item = NSCollectionLayoutItem(
            layoutSize: itemSize
        )

        item.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 12,
            trailing: 12
        )

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(320),
            heightDimension: .absolute(240)
        )

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(
            group: group
        )

        section.orthogonalScrollingBehavior = .continuous

        section.contentInsets = NSDirectionalEdgeInsets(
            top: 16,
            leading: 16,
            bottom: 20,
            trailing: 16
        )

        return section
    }
}


// MARK: - Latest Section

extension LeagueDetailsViewController {

    private func createLatestSection()
    -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )

        let item = NSCollectionLayoutItem(
            layoutSize: itemSize
        )

        item.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 16,
            trailing: 0
        )

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(280)
        )

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(
            group: group
        )

        section.contentInsets = NSDirectionalEdgeInsets(
            top: 16,
            leading: 16,
            bottom: 20,
            trailing: 16
        )

        return section
    }
}


// MARK: - Teams Section

extension LeagueDetailsViewController {

    private func createTeamsSection()
    -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )

        let item = NSCollectionLayoutItem(
            layoutSize: itemSize
        )

        item.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 12,
            trailing: 12
        )

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(120),
            heightDimension: .absolute(140)
        )

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(
            group: group
        )

        section.orthogonalScrollingBehavior = .continuous

        section.contentInsets = NSDirectionalEdgeInsets(
            top: 16,
            leading: 16,
            bottom: 20,
            trailing: 16
        )

        return section
    }
}


// MARK: - CollectionView DataSource

extension LeagueDetailsViewController:
UICollectionViewDataSource,
UICollectionViewDelegate {
    
    
    func numberOfSections(
        in collectionView: UICollectionView
    ) -> Int {
        
        return Section.allCases.count
    }
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        
        switch Section(rawValue: section)! {
            
        case .upcoming:
            let count = presenter.getUpcomingCount()
            print("Upcoming Count: \(count)")
            return presenter.getUpcomingCount()
            
        case .latest:
            let count = presenter.getLatestCount()
            print("Latest Count: \(count)")
            return presenter.getLatestCount()
            
        case .teams:
            let count = presenter.getTeamsCount()
            print("Teams Count: \(count)")
            return presenter.getTeamsCount()
        }
    }
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        let section = Section(
            rawValue: indexPath.section
        )
        
        
        switch section {
            
            
        // MARK: Upcoming
            
        case .upcoming:
            
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "UpcomingEventCell",
                for: indexPath
            ) as! UpcomingEventCell
            
            let event = presenter.getUpcomingEvent(
                at: indexPath.row
            )
            
            cell.configure(event: event)
            
            return cell
            
            
        // MARK: Latest
            
        case .latest:
            
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "LatestEventCell",
                for: indexPath
            ) as! LatestEventCell
            
            let event = presenter.getLatestEvent(
                at: indexPath.row
            )
            
            cell.configure(event: event)
            
            return cell
            
            
        // MARK: Teams
            
        case .teams:
            
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "TeamCell",
                for: indexPath
            ) as! TeamCell
            
            let team = presenter.getTeam(
                at: indexPath.row
            )
            
            cell.configure(team: team)
            
            return cell
            
            
        default:
            return UICollectionViewCell()
        }
    }
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        
        let section = Section(
            rawValue: indexPath.section
        )
        
        switch section {
            
        case .teams:
            let team = presenter.getTeam(at: indexPath.row)

                let storyboard = UIStoryboard(
                    name: "Main",
                    bundle: nil
                )

                let teamDetailsVC =
                storyboard.instantiateViewController(
                    withIdentifier: "TeamDetailsViewController"
                ) as! TeamDetailsViewController

                teamDetailsVC.team = team

                navigationController?.pushViewController(
                    teamDetailsVC,
                    animated: true
                )
            
        default:
            break
        }
    }
}


// MARK: - View Protocol

extension LeagueDetailsViewController:
LeagueDetailsViewProtocol {
    func startLoading() {
        
        indicator.center = view.center
        
        view.addSubview(indicator)
        
        indicator.startAnimating()
    }
    
    func stopLoading() {
        
        indicator.stopAnimating()
        
        indicator.removeFromSuperview()
    }
    
    
    func reloadData() {

        DispatchQueue.main.async {

            self.collectionView.reloadData()

            let totalItems =
            self.presenter.getUpcomingCount() +
            self.presenter.getLatestCount() +
            self.presenter.getTeamsCount()

            self.emptyLabel.isHidden = totalItems != 0
        }
    }
    
    
    func showError(message: String) {
        
        let alert = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: .default
            )
        )
        
        present(alert, animated: true)
    }
}


// MARK: - Sections Enum

extension LeagueDetailsViewController {
    
    enum Section: Int, CaseIterable {
        
        case upcoming
        
        case latest
        
        case teams
    }
}
