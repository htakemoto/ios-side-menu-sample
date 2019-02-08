//
//  FavTwoViewController.swift
//  SideMenu
//
//  Created by Hiroshi Takemoto on 2/8/19.
//

import UIKit

class FavTwoViewController: UIViewController {
    
    // MARK: View Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("FavTwoViewController:viewWillAppear")
        self.tabBarController?.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_menu"), style: .plain, target: self, action: #selector(menuButtonPressed))
    }
    
    // MARK: Button Actions
    
    @objc func menuButtonPressed(sender: UIBarButtonItem) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.appMenu?.showMenu()
    }

}
