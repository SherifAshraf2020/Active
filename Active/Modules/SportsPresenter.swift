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
        
        NetworkService.shared.fetchData(urlString: APIConstants.sportsBaseURL, type: SportResponse.self) { [weak self] result in
            self?.view?.stopLoading()
            
            switch result {
            case .success(let response):
                self?.view?.displaySports(response.sports)
            case .failure(let error):
                self?.view?.displayError(message: error.localizedDescription)
            }
        }
    }
}
