//
//  MenuViewController.swift
//  SideMenu
//
//  Created by Hiroshi Takemoto on 3/2/18.
//

import UIKit

enum DisplayStyle {
    case change
    case push
    case modal
}

struct MenuItem {
    var name: String
    var icon: String
    var id: String
    var storyboard: String
    var displayStyle: DisplayStyle
}

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Properties

    var menuItems: [MenuItem] = []
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    
    // MARK: View Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menuTableView.delegate = self
        menuTableView.dataSource = self
        
        var menuItem = MenuItem.init(name:"Main", icon:"ic_home", id: "Main", storyboard: "Main", displayStyle: DisplayStyle.change)
        menuItems.append(menuItem)
        menuItem = MenuItem.init(name:"Profile", icon:"ic_account_box", id: "Profile", storyboard: "Profile", displayStyle: DisplayStyle.change)
        menuItems.append(menuItem)
        menuItem = MenuItem.init(name:"Favorites", icon:"ic_favorite_border", id: "Favorites", storyboard: "Favorites", displayStyle: DisplayStyle.change)
        menuItems.append(menuItem)
        menuItem = MenuItem.init(name:"Settings", icon:"ic_settings", id: "Settings", storyboard: "Settings", displayStyle: DisplayStyle.push)
        menuItems.append(menuItem)
        menuItem = MenuItem.init(name:"Logout", icon:"ic_exit_to_app", id: "Login", storyboard: "Main", displayStyle: DisplayStyle.modal)
        menuItems.append(menuItem)
        
        self.view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.insertSubview(blurEffectView, at: 0)
        
        if (AuthService.shared.isAuthenticated) {
            let user = AuthService.shared.getUserInfo()
            userNameLabel.text = "\(user.firstName) \(user.lastName)"
            userEmailLabel.text = "\(user.email)"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableViewDataSource & UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = menuTableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as? MenuItemTableCell else {
            fatalError("The dequeued cell is not an instance of MenuItemTableCell.")
        }
        let menuItem = menuItems[indexPath.row]
        cell.iconImageView.image = UIImage(named: menuItem.icon)
        cell.nameLabel.text = menuItems[indexPath.row].name
        
        if (menuItem.displayStyle == DisplayStyle.push) {
            cell.accessoryType = .disclosureIndicator
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let menuItem = menuItems[indexPath.row]
        
        // reset viewControllers inside of rootViewController
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        guard let navigationController = rootViewController as? UINavigationController else { return }
        print("# of views in navigationController \(navigationController.viewControllers.count)")
        print("first view name in root view controller \(navigationController.viewControllers[0])")
        
        // set a selected viewController
        let storyboard = UIStoryboard(name: menuItem.storyboard, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: menuItem.id)
        
        if (menuItem.displayStyle == DisplayStyle.change) {
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
        else if (menuItem.displayStyle == DisplayStyle.push) {
            navigationController.pushViewController(viewController, animated: true)
        }
        else {
            // option 1: use current navigationController (viewController in container is optional)
            let container = UINavigationController(rootViewController: viewController)
            if (menuItem.name == "Logout") {
                container.setNavigationBarHidden(true, animated: false)
                AuthService.shared.logout()
            }
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
        self.hideMenu()
    }
    
    // MARK: - Menu Actions

    func showMenu() {
        UIApplication.shared.keyWindow?.rootViewController?.view.addSubview(self.view)
        
        self.beginAppearanceTransition(true, animated: true)
        self.view.isHidden = false
        self.view.alpha = 0
        self.menuView.frame = self.menuView.frame.offsetBy(dx: -self.menuView.frame.size.width, dy: 0)
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.view.alpha = 1
            let bounds = self.menuView.bounds
            self.menuView.frame = CGRect(x:0, y:0, width:bounds.size.width, height:bounds.size.height)
        }, completion: {_ in
            self.endAppearanceTransition()
        })
        
    }
    
    func hideMenu() {
        self.beginAppearanceTransition(false, animated: true)
        self.view.isHidden = false
        self.view.alpha = 1
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.view.alpha = 0
            self.menuView.frame = self.menuView.frame.offsetBy(dx: -self.menuView.frame.size.width, dy: 0)
        }, completion: {_ in
            self.view.isHidden = true
            self.endAppearanceTransition()
            self.view.removeFromSuperview()
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: view)
            if (position.x > self.menuView.bounds.size.width) {
                self.hideMenu()
            }
        }
    }
    
}
