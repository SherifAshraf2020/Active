//
//  OnboardingService.swift
//  Active
//
//  Created by Sherif Ashraf Farooq  on 10/05/2026.
//

import UIKit

class OnboardingService {
    
    static func getOnboardingSlides() -> [OnboardingSlide] {
            return [
                OnboardingSlide(title: "World Leagues",
                                description: "Follow all your favorite sports leagues in one place.",
                                image: UIImage(systemName: "sportscourt.fill")),
                
                OnboardingSlide(title: "Live Results",
                                description: "Get instant updates on matches and scores.",
                                image: UIImage(systemName: "clock.fill")),
                
                OnboardingSlide(title: "Your Favorites",
                                description: "Access your saved teams and leagues quickly.",
                                image: UIImage(systemName: "heart.circle.fill"))
            ]
        }
}
