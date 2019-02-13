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
    
    // MARK: Button Actions
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        AuthService.shared.login(username: "", password: "")
        self.dismiss(animated: true, completion: nil)
    }

}
