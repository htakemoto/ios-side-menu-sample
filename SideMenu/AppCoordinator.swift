//
//  AppCoordinator.swift
//  SideMenu
//
//  Created by Hiroshi Takemoto on 2019-02-23.
//

import UIKit

class AppCoordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Main")
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func showMain() {
        // reset viewControllers inside of rootViewController
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        guard let navigationController = rootViewController as? UINavigationController else { return }
        print("# of views in navigationController \(navigationController.viewControllers.count)")
        print("first view name in root view controller \(navigationController.viewControllers[0])")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Main")
        // option 1: reset the current view controller to new one in stack of navigation controller
        navigationController.setViewControllers([viewController], animated: false)
        
        // Option 2: add a new view controller on top of the first view controller in stack of navigation controller
        // if (navigationController.viewControllers.count > 0) {
        //     navigationController.popToViewController(navigationController.viewControllers[0], animated: false)
        // }
        // if (object_getClassName(viewController) != object_getClassName(navigationController.viewControllers[0])) {
        //     navigationController.pushViewController(viewController, animated: false)
        // }
    }
    
    func showProfile() {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Profile")
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func showFavorites() {
        let storyboard = UIStoryboard(name: "Favorites", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Favorites")
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func showSettings() {
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Settings")
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showLogin() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Login")
        
        // option 1: use current navigationController (viewController in container is optional)
        let container = UINavigationController(rootViewController: viewController)
        container.setNavigationBarHidden(true, animated: false)
        AuthService.shared.logout()
        navigationController.present(container, animated: true, completion: nil)
        
        // option 2: search current viewController to present on top of it
        // if let window = UIApplication.shared.delegate?.window {
        //    if var currentViewController = window?.rootViewController {
        //        // handle navigation controllers
        //        if (currentViewController is UINavigationController){
        //            currentViewController = (currentViewController as! UINavigationController).visibleViewController!
        //        }
        //        currentViewController.present(viewController, animated: true, completion: nil)
        //    }
        // }
    }
    
}
