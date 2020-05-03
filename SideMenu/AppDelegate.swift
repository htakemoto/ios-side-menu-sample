//
//  AppDelegate.swift
//  SideMenu
//
//  Created by Hiroshi Takemoto on 3/2/18.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appMenu: MenuViewController?
    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // set default navigation bar style
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.barStyle = .black
        navigationBarAppearace.barTintColor = UIColor(red: 30/255, green: 70/255, blue: 160/255, alpha: 1)
        navigationBarAppearace.tintColor = UIColor.white
        navigationBarAppearace.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        // initialize MenuViewController for side menu
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Menu")
        appMenu = viewController as? MenuViewController
        
        // instantiate AppCoordinator for page navigation
        // option 1: use UINavigationController object defined from Storyboard
        if let rootViewController = window?.rootViewController {
            if (rootViewController is UINavigationController) {
                self.appCoordinator = AppCoordinator(navigationController: rootViewController as! UINavigationController)
                self.appCoordinator?.start()
            }
        }
        
        // option 2: initialize initialViewController object from storyboard
//        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
//        appCoordinator = AppCoordinator(navigationController: navigationController)
//        appCoordinator?.start()
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = navigationController
//        window?.makeKeyAndVisible()
        
        // option 3: initialize UINavigationController object
//        let navigationController = UINavigationController()
//        appCoordinator = AppCoordinator(navigationController: navigationController)
//        appCoordinator?.start()
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = navigationController
//        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        // show login screen
        if (AuthService.shared.isAuthenticated == false) {
            if let window = UIApplication.shared.delegate?.window {
                if var currentViewController = window?.rootViewController {
                    // handle navigation controllers
                    if (currentViewController is UINavigationController) {
                        currentViewController = (currentViewController as! UINavigationController).visibleViewController!
                    }
                    // prevent from opening another login screen on login screen
                    if !(currentViewController is LoginViewController) {
                        appCoordinator?.showLogin(animated: false)
                    }
                }
            }
        }
        // show onboarding screen for the fisrt lanuch
        let isFirstLaunch = Preferences.isFirstLaunch()
        if (isFirstLaunch) {
            appCoordinator?.showOnboarding(animated: false)
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

