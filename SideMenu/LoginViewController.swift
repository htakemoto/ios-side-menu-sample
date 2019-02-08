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
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: Button Actions
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        // set a selected viewController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Main")
        
        // reset viewControllers inside of rootViewController
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        guard let navigationController = rootViewController as? UINavigationController else { return }
        navigationController.viewControllers = [viewController]
        navigationController.setNavigationBarHidden(false, animated: false)
    }

}
