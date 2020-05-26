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
        loadUser()
    }
    
    // MARK: - Actions
    
    @IBAction func unwindToSettings(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AccountTableViewController, let user = sourceViewController.user {
            AuthService.shared.updateUserInfo(user)
            loadUser()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
        case "SettingsToAccount":
            guard let destinationVC = segue.destination as? AccountTableViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            destinationVC.user = AuthService.shared.getUserInfo()
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    
    // MARK: Private Methods
    
    private func loadUser() {
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
