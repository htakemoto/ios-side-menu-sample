//
//  MenuViewController.swift
//  SideMenu
//
//  Created by Hiroshi Takemoto on 3/2/18.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Properties

    var menuItems: [MenuItem] = []
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var menuTableView: UITableView!
    
    // MARK: View Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menuTableView.delegate = self
        menuTableView.dataSource = self
        
        var menuItem = MenuItem.init(name:"Main", icon:"ic_home", storyboard: "Main")
        menuItems.append(menuItem)
        menuItem = MenuItem.init(name:"Profile", icon:"ic_account_box", storyboard: "Profile")
        menuItems.append(menuItem)
        menuItem = MenuItem.init(name:"Favorites", icon:"ic_favorite_border", storyboard: "Favorites")
        menuItems.append(menuItem)
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
        cell.nameLabel.text = menuItems[indexPath.row].displayName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let menuItem = menuItems[indexPath.row]
        
        // set a selected viewController
        let storyboard = UIStoryboard(name: menuItem.storyboard, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: menuItem.storyboard)
        
        // reset viewControllers inside of rootViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = UINavigationController(rootViewController: viewController)
        appDelegate.window?.makeKeyAndVisible()
        
        self.hideMenu()
    }
    
    // MARK: - Menu Actions

    func showMenu() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController?.view.addSubview(self.view)
        
        self.beginAppearanceTransition(true, animated: true)
        self.view.isHidden = false
        self.view.alpha = 0
        self.menuView.frame = self.menuView.frame.offsetBy(dx: -self.menuView.frame.size.width, dy: 0)
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.curveEaseOut, animations: {
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
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.curveEaseOut, animations: {
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
