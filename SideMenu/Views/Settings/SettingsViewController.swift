//
//  SettingsViewController.swift
//  SideMenu
//
//  Created by Hiroshi Takemoto on 2/12/19.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var buildLabel: UILabel!
    
    // MARK: View Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Settings"
        versionLabel.text = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String ?? "?"
        buildLabel.text = Bundle.main.infoDictionary!["CFBundleVersion"] as? String ?? "?"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}
