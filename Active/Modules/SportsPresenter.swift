//
//  SportsPresenter.swift
//  Active
//
//  Created by Sherif Ashraf Farooq  on 06/05/2026.
//

import Foundation

protocol SportsViewProtocol: AnyObject {
    func startLoading()
    func stopLoading()
    func displaySports(_ sports: [Sport])
    func displayError(message: String)
}

class SportsPresenter {
    
    private weak var view: SportsViewProtocol?
    
    init(view: SportsViewProtocol) {
        self.view = view
    }
    
    func getSports() {
            view?.startLoading()
            
            let staticSports = [
                Sport(idSport: "102", strSport: "Football", strSportThumb: "https://www.thesportsdb.com/images/sports/soccer.jpg"),
                Sport(idSport: "103", strSport: "Basketball", strSportThumb: "https://www.thesportsdb.com/images/sports/basketball.jpg"),
                Sport(idSport: "104", strSport: "Tennis", strSportThumb: "https://www.thesportsdb.com/images/sports/tennis.jpg"),
                Sport(idSport: "115", strSport: "Cricket", strSportThumb: "https://www.thesportsdb.com/images/sports/cricket.jpg")
            ]
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.view?.stopLoading()
                self?.view?.displaySports(staticSports)
            }
        }
}
