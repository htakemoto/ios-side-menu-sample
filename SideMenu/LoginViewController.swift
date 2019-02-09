//
//  LoginViewController.swift
//  SideMenu
//
//  Created by Hiroshi Takemoto on 2/9/19.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: View Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("LoginViewController:viewWillAppear")
    }
    
    // MARK: Button Actions
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
