//
//  OnboardingTabViewController.swift
//  SideMenu
//
//  Created by Hiroshi Takemoto on 2019-03-02.
//

import UIKit

class OnboardingPageViewController: UIPageViewController {
    
    // MARK: Properties
    
    var currentPageIndex = 0
    
    lazy var subViewControllers: [UIViewController] = {
        return [
            UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewController(withIdentifier: "OnboardingPage1"),
            UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewController(withIdentifier: "OnboardingPage2"),
            UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewController(withIdentifier: "OnboardingPage3"),
            UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewController(withIdentifier: "OnboardingPageLast") as! OnboardingPageLastViewController
        ]
    }()
    
    lazy var pageControl: UIPageControl = {
        return UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 150, width: UIScreen.main.bounds.width, height: 150))
    }()
    
    // MARK: View Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        if let firstViewController = subViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        configurePageControl()
        
        // solve black screen issue when swiping towards first or very last page
        view.backgroundColor = UIColor.white
        // set navigation bar background color & boarder color to nothing
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        // set tool bar background color & boarder color to nothing
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.toolbar.setBackgroundImage(UIImage(), forToolbarPosition: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        navigationController?.toolbar.clipsToBounds = true
    }
    
    // MARK: Button Actions
    
    @IBAction func closeButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButtonTapped(_ sender: UIBarButtonItem) {
        goToNextPage()
    }
    
    @IBAction func skipButtonTapped(_ sender: UIBarButtonItem) {
        goToLastPage()
    }
    
    
    // MARK: Private Methods
    
    private func configurePageControl() {
        pageControl.isEnabled = false
        pageControl.numberOfPages = subViewControllers.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.darkGray
        self.view.addSubview(pageControl)
    }
    
    private func goToNextPage(animated: Bool = true) {
        let currentViewController = subViewControllers[pageControl.currentPage]
        guard let nextViewController = dataSource?.pageViewController(self, viewControllerAfter: currentViewController) else { return }
        setViewControllers([nextViewController], direction: .forward, animated: animated, completion: nil)
        pageControl.currentPage = subViewControllers.index(of: nextViewController)!
    }
    
    private func goToPreviousPage(animated: Bool = true) {
        let currentViewController = subViewControllers[pageControl.currentPage]
        guard let previousViewController = dataSource?.pageViewController(self, viewControllerBefore: currentViewController) else { return }
        setViewControllers([previousViewController], direction: .reverse, animated: animated, completion: nil)
        pageControl.currentPage = subViewControllers.index(of: previousViewController)!
    }
    
    private func goToLastPage(animated: Bool = true) {
        guard let lastViewController = subViewControllers.last else { return }
        setViewControllers([lastViewController], direction: .forward, animated: animated, completion: nil)
        pageControl.currentPage = subViewControllers.index(of: lastViewController)!
    }
}

extension OnboardingPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    // MARK: UIPageViewControllerDataSource
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex:Int = subViewControllers.index(of: viewController) ?? 0
        if (currentIndex <= 0) {
            return nil
        }
        return subViewControllers[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex:Int = subViewControllers.index(of: viewController) ?? 0
        if (currentIndex >= subViewControllers.count - 1) {
            return nil
        }
        return subViewControllers[currentIndex + 1]
    }
    
    // MARK: UIPageViewControllerDelegate
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        pageControl.currentPage = subViewControllers.index(of: pageContentViewController)!
    }
    
}
