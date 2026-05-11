//
//  OnboardingPresenter.swift
//  Active
//
//  Created by Sherif Ashraf Farooq  on 10/05/2026.
//

import Foundation

protocol OnboardingViewProtocol: AnyObject {
    func showSlides(_ slides: [OnboardingSlide])
    func navigateToHome()
}

class OnboardingPresenter {
    
    weak var view: OnboardingViewProtocol?
    
    init(view: OnboardingViewProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        let slides = OnboardingService.getOnboardingSlides()
        view?.showSlides(slides)
    }
    
    func finishOnboarding() {
            UserDefaults.standard.set(true, forKey: "onboardingDone")
            view?.navigateToHome()
        }
}
