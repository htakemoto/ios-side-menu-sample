//
//  ProfileViewController.swift
//  SideMenu
//
//  Created by Hiroshi Takemoto on 3/2/18.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: View Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Button Actions
    
    @IBAction func menuButtonPressed(_ sender: UIBarButtonItem) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.appMenu?.showMenu()
    }

}
