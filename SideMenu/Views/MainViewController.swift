//
//  MainViewController.swift
//  SideMenu
//
//  Created by Hiroshi Takemoto on 3/2/18.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - View Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Button Actions
    
    @IBAction func menuButtonPressed(_ sender: UIBarButtonItem) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.appMenu?.showMenu()
    }

}
