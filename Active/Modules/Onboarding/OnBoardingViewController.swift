//
//  OnBoardingViewController.swift
//  Active
//
//  Created by Sherif Ashraf Farooq  on 10/05/2026.
//

import UIKit

class OnBoardingViewController: UIPageViewController {
    
    // MARK: - Properties
    var presenter: OnboardingPresenter!
    var slides: [OnboardingSlide] = []
    var currentIndex = 0
    
    // UI Components
    let pageControl = UIPageControl()
    let actionButton = UIButton(type: .system)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        dataSource = self
        delegate = self
        
        presenter = OnboardingPresenter(view: self)
        presenter.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        pageControl.currentPageIndicatorTintColor = .label
        pageControl.pageIndicatorTintColor = .systemGray4
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageControl)
        
        actionButton.setTitle("Next", for: .normal)
        actionButton.backgroundColor = .label
        actionButton.setTitleColor(.systemBackground, for: .normal)
        actionButton.layer.cornerRadius = 25
        actionButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.addSubview(actionButton)
        
        // Constraints
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -120),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionButton.widthAnchor.constraint(equalToConstant: 220),
            actionButton.heightAnchor.constraint(equalToConstant: 54)
        ])
    }
    
    @objc private func buttonTapped() {
        if currentIndex < slides.count - 1 {
            currentIndex += 1
            if let nextVC = createSlideVC(at: currentIndex) {
                setViewControllers([nextVC], direction: .forward, animated: true)
                pageControl.currentPage = currentIndex
                updateButtonTitle()
            }
        } else {
           
            print("Finished Onboarding!")
        }
    }
    
    private func updateButtonTitle() {
        let title = (currentIndex == slides.count - 1) ? "Get Started" : "Next"
        actionButton.setTitle(title, for: .normal)
    }
    
    private func createSlideVC(at index: Int) -> SlideViewController? {
        if index < 0 || index >= slides.count { return nil }
        let vc = SlideViewController()
        vc.slide = slides[index]
        vc.index = index
        return vc
    }
}

// MARK: - OnboardingViewProtocol Implementation
extension OnBoardingViewController: OnboardingViewProtocol {
    func showSlides(_ slides: [OnboardingSlide]) {
        self.slides = slides
        pageControl.numberOfPages = slides.count
        
        if let firstVC = createSlideVC(at: 0) {
            setViewControllers([firstVC], direction: .forward, animated: true)
        }
    }
}

// MARK: - PageView DataSource & Delegate
extension OnBoardingViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let current = viewController as? SlideViewController else { return nil }
        return createSlideVC(at: current.index - 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let current = viewController as? SlideViewController else { return nil }
        return createSlideVC(at: current.index + 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed, let current = pageViewController.viewControllers?.first as? SlideViewController {
            currentIndex = current.index
            pageControl.currentPage = currentIndex
            updateButtonTitle()
        }
    }
}
