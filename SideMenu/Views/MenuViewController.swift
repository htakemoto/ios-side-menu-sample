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
    var displayStyle: DisplayStyle
}

class MenuViewController: UIViewController {
    
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
        
        var menuItem = MenuItem.init(name:"Main", icon:"ic_home", displayStyle: DisplayStyle.change)
        menuItems.append(menuItem)
        menuItem = MenuItem.init(name:"Profile", icon:"ic_account_box", displayStyle: DisplayStyle.change)
        menuItems.append(menuItem)
        menuItem = MenuItem.init(name:"Favorites", icon:"ic_favorite_border", displayStyle: DisplayStyle.change)
        menuItems.append(menuItem)
        menuItem = MenuItem.init(name:"Settings", icon:"ic_settings", displayStyle: DisplayStyle.push)
        menuItems.append(menuItem)
        menuItem = MenuItem.init(name:"Sign out", icon:"ic_exit_to_app", displayStyle: DisplayStyle.modal)
        menuItems.append(menuItem)
        
        setBlurEffectOnBackground()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("MenuViewController:viewWillAppear")
        setUser()
    }
    
    // MARK: - Private Methods
    
    private func setBlurEffectOnBackground() {
        self.view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.insertSubview(blurEffectView, at: 0)
    }
    
    private func setUser() {
        if (AuthService.shared.isAuthenticated) {
            let user = AuthService.shared.getUserInfo()
            userNameLabel.text = "\(user.firstName) \(user.lastName)"
            userEmailLabel.text = "\(user.email)"
        }
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

extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
    
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
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        var isHideMenu = true
        switch menuItem.name {
        case "Profile":
            appDelegate.appCoordinator?.showProfile()
        case "Favorites":
            appDelegate.appCoordinator?.showFavorites()
        case "Settings":
            appDelegate.appCoordinator?.showSettings()
        case "Sign out":
            isHideMenu = false
            let alert = UIAlertController(title: "Sign out", message: "Are you sure you want to sign out?", preferredStyle:  UIAlertController.Style.alert)
            let defaultAction = UIAlertAction(title: "Sign out", style: .destructive, handler: {
                (action: UIAlertAction!) -> Void in
                self.hideMenu()
                appDelegate.appCoordinator?.showLogin(animated: true)
            })
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            alert.addAction(defaultAction)
            // workaround for UIAlertController showing with delay
            DispatchQueue.main.async {
                appDelegate.appCoordinator?.navigationController.present(alert, animated: true, completion: nil)
            }
        default: // = "Main"
            appDelegate.appCoordinator?.showMain()
        }
        if (isHideMenu) {
            self.hideMenu()
        }
    }
    
}
