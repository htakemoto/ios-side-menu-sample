//
//  OnboardingLastPageViewController.swift
//  SideMenu
//
//  Created by Hiroshi Takemoto on 2019-03-02.
//

import UIKit

class OnboardingPageLastViewController: UIViewController {

    // MARK: View Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.setToolbarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.setToolbarHidden(false, animated: false)
    }
    
    // MARK: - Button Actions
    
    @IBAction func goButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
