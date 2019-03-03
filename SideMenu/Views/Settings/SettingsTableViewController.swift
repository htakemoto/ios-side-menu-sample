//
//  SettingsViewController.swift
//  SideMenu
//
//  Created by Hiroshi Takemoto on 2/12/19.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var buildLabel: UILabel!
    @IBOutlet weak var userGuideCell: UITableViewCell!
    
    // MARK: View Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
        
        let userGuideGesture = UITapGestureRecognizer(target: self, action: #selector(userGuideTapped))
        userGuideCell.addGestureRecognizer(userGuideGesture)
        userGuideGesture.delegate = userGuideCell
        
        // hide Back text from navigation bar on the next screen
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUser()
    }
    
    // MARK: Private Methods
    
    private func updateUser() {
        let user = AuthService.shared.getUserInfo()
        fullNameLabel.text = "\(user.firstName) \(user.lastName)"
        versionLabel.text = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String ?? "?"
        buildLabel.text = Bundle.main.infoDictionary!["CFBundleVersion"] as? String ?? "?"
    }
    
    @objc private func userGuideTapped(recognizer: UITapGestureRecognizer) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.appCoordinator?.showOnboarding(animated: true)
    }
    
}
