//
//  PeoplePageViewController.swift
//  SideMenu
//
//  Created by Hiroshi Takemoto on 2/13/19.
//

import UIKit

class ContactsPageViewController: UIPageViewController {
    
    // MARK: Properties
    
    lazy var subViewControllers: [UIViewController] = {
        return [
            UIStoryboard(name: "Favorites", bundle: nil).instantiateViewController(withIdentifier: "PageOne") as! PageOneViewController,
            UIStoryboard(name: "Favorites", bundle: nil).instantiateViewController(withIdentifier: "PageTwo") as! PageTwoViewController
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
    }
    
    // MARK: Private Methods
    
    func configurePageControl() {
        pageControl.isEnabled = false
        pageControl.numberOfPages = subViewControllers.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.darkGray
        self.view.addSubview(pageControl)
    }

}

extension ContactsPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
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
