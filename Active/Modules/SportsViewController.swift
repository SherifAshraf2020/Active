//
//  SportsViewController.swift
//  Active
//
//  Created by Sherif Ashraf Farooq  on 06/05/2026.
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
        iv.image = UIImage(systemName: "wifi.exclamationmark")
        iv.tintColor = .systemGray
        iv.contentMode = .scaleAspectFit
        iv.isHidden = true
        return iv
    }()

    let noInternetLabel: UILabel = {
        let label = UILabel()
        label.text = "No Internet Connection\nPlease check your network"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .systemGray
        label.isHidden = true
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    
        presenter = SportsPresenter(view: self)
        presenter.getSports()
        
        sportsCollectionView.delegate = self
        sportsCollectionView.dataSource = self
    }
    
    
    private func setupUI(){
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
                noInternetImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
                noInternetImageView.widthAnchor.constraint(equalToConstant: 150),            noInternetImageView.heightAnchor.constraint(equalToConstant:150),
                noInternetLabel.topAnchor.constraint(equalTo: noInternetImageView.bottomAnchor, constant: 16),
                noInternetLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                noInternetLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                noInternetLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            ])
            
        activityIndicator.hidesWhenStopped = true
            activityIndicator.color = .gray
            noInternetLabel.numberOfLines = 0
    }
    
    
}

extension SportsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print("UI is asking for number of items. Current count: \(sportsList.count)")
        return sportsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SportCell", for: indexPath) as! SportsCollectionViewCell
        
        let sport = sportsList[indexPath.row]
        cell.sportLabel.text = sport.strSport
        
        if let url = URL(string: sport.strSportThumb) {
                    cell.sportImageView.kf.setImage(
                        with: url,
                        placeholder: UIImage(named: "placeholder"),
                        options: [
                            .transition(.fade(0.4)),                         .cacheOriginalImage
                        ]
                    )
                }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sport = sportsList[indexPath.row]
        
        if let leaguesVC = storyboard?.instantiateViewController(withIdentifier: "LeaguesTableViewController") as? LeaguesTableViewController {
            leaguesVC.selectedSport = sport.strSport 
            self.navigationController?.pushViewController(leaguesVC, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 20
        let spacing: CGFloat = 15
        
        let availableWidth = collectionView.frame.width - (padding * 2) - spacing
        let width = availableWidth / 2
        
        if collectionView.frame.width > collectionView.frame.height {
            return CGSize(width: width, height: 120)
        } else {
            return CGSize(width: width, height: width * 1.1)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { _ in
            self.sportsCollectionView.collectionViewLayout.invalidateLayout()
        }, completion: nil)
    }
}

extension SportsViewController: SportsViewProtocol {
    func displaySports(_ sports: [Sport]) {
        
        print("Successfully fetched \(sports.count) sports from API")
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
            let alert = UIAlertController(title: "Error", message: "Failed to load sports. Please try again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { _ in
                self.presenter.getSports()
            }))
            self.present(alert, animated: true)
            
            if self.sportsList.isEmpty {
                self.noInternetImageView.isHidden = false
                self.noInternetLabel.isHidden = false
                self.sportsCollectionView.isHidden = true
            }
        }
    }
}
