//
//  RootViewController.swift
//  SideMenu
//
//  Created by Hiroshi Takemoto on 2/8/19.
//

import UIKit

class RootTabViewController: UIViewController {
    
    // MARK: View Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("RootTabViewController:viewWillAppear")
        setMenuButton()
    }
    
    // MARK: Private Methods
    
    private func setMenuButton() {
        self.tabBarController?.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_menu"), style: .plain, target: self, action: #selector(menuButtonTapped))
    }
    
    @objc func menuButtonTapped(sender: UIBarButtonItem) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.appMenu?.showMenu()
    }

}
