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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = SportsPresenter(view: self)
        presenter.getSports()
        
        sportsCollectionView.delegate = self
        sportsCollectionView.dataSource = self
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 40
        let side = (collectionView.frame.size.width - padding) / 2
        return CGSize(width: 150, height: 150)
    }
}

extension SportsViewController: SportsViewProtocol {
    func displaySports(_ sports: [Sport]) {
        
        print("Successfully fetched \(sports.count) sports from API")
        self.sportsList = sports
        DispatchQueue.main.async {
            self.sportsCollectionView.reloadData()
        }
    }
    
    func startLoading() {}
    
    func stopLoading() {}
    
    func displayError(message: String) {
        print(message)
    }
}
