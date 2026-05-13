//
//  SportsViewController.swift
//  Active
//
//  Created by Sherif Ashraf Farooq  on 06/05/2026.
//

//
//  SportsViewController.swift
//  Active
//

import UIKit
import Kingfisher

class SportsViewController: UIViewController {

    @IBOutlet weak var sportsCollectionView: UICollectionView!

    var sportsList: [Sport] = []
    var presenter: SportsPresenter!

    let activityIndicator = UIActivityIndicatorView(style: .large)

    let noInternetImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "wifi.slash")
        iv.tintColor = .white
        iv.contentMode = .scaleAspectFit
        iv.isHidden = true
        return iv
    }()

    let noInternetLabel: UILabel = {
        let label = UILabel()
        label.text = "No Internet Connection\nPlease check your network"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .white
        label.isHidden = true
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = traitCollection.userInterfaceStyle == .dark
        ? UIColor(red: 18/255, green: 18/255, blue: 24/255, alpha: 1)
        : .systemBackground
        setupUI()
        configureCollectionView()

        presenter = SportsPresenter(view: self)
        presenter.getSports()
    }

    // MARK: - UI

    private func setupUI() {

        title = "Sports"

        navigationController?.navigationBar.prefersLargeTitles = true

        view.addSubview(activityIndicator)
        view.addSubview(noInternetImageView)
        view.addSubview(noInternetLabel)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        noInternetImageView.translatesAutoresizingMaskIntoConstraints = false
        noInternetLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            noInternetImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noInternetImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -70),
            noInternetImageView.widthAnchor.constraint(equalToConstant: 120),
            noInternetImageView.heightAnchor.constraint(equalToConstant: 120),

            noInternetLabel.topAnchor.constraint(equalTo: noInternetImageView.bottomAnchor, constant: 20),
            noInternetLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noInternetLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            noInternetLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)

        ])

        activityIndicator.color = .white
        activityIndicator.hidesWhenStopped = true
    }

    private func configureCollectionView() {

        sportsCollectionView.delegate = self
        sportsCollectionView.dataSource = self

        sportsCollectionView.backgroundColor = .clear

        if let layout = sportsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 20
            layout.minimumInteritemSpacing = 15
        }
    }
}

// MARK: - CollectionView

extension SportsViewController: UICollectionViewDelegate,
                                UICollectionViewDataSource,
                                UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {

        return sportsList.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "SportCell",
            for: indexPath
        ) as! SportsCollectionViewCell

        let sport = sportsList[indexPath.row]

        cell.configure(with: sport)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {

        let sport = sportsList[indexPath.row]

        if !NetworkMonitor.shared.checkConnection() {

            self.displayError(message: "Internet connection is required.")
            return
        }

        if let leaguesVC = storyboard?.instantiateViewController(
            withIdentifier: "LeaguesTableViewController"
        ) as? LeaguesTableViewController {

            leaguesVC.selectedSport = sport.strSport

            navigationController?.pushViewController(leaguesVC, animated: true)
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let padding: CGFloat = 20
        let spacing: CGFloat = 15

        let availableWidth =
        collectionView.frame.width - (padding * 2) - spacing

        let width = availableWidth / 2

        return CGSize(width: width, height: width * 1.25)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 20, left: 20, bottom: 30, right: 20)
    }
}

// MARK: - View Protocol

extension SportsViewController: SportsViewProtocol {

    func displaySports(_ sports: [Sport]) {

        self.sportsList = sports

        DispatchQueue.main.async {

            self.noInternetImageView.isHidden = true
            self.noInternetLabel.isHidden = true
            self.sportsCollectionView.isHidden = false

            self.sportsCollectionView.reloadData()
        }
    }

    func startLoading() {

        DispatchQueue.main.async {

            self.activityIndicator.startAnimating()
        }
    }

    func stopLoading() {

        DispatchQueue.main.async {

            self.activityIndicator.stopAnimating()
        }
    }

    func displayError(message: String) {

        DispatchQueue.main.async {

            let alert = UIAlertController(
                title: "Error",
                message: message,
                preferredStyle: .alert
            )

            alert.addAction(UIAlertAction(
                title: "Retry",
                style: .default,
                handler: { _ in
                    self.presenter.getSports()
                }
            ))

            self.present(alert, animated: true)

            if self.sportsList.isEmpty {

                self.noInternetImageView.isHidden = false
                self.noInternetLabel.isHidden = false
                self.sportsCollectionView.isHidden = true
            }
        }
    }
}
