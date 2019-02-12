//
//  FavoritesTabBarController.swift
//  SideMenu
//
//  Created by Hiroshi Takemoto on 2/8/19.
//

import UIKit

class FavoritesTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorites"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("FavoritesTabBarController:viewWillAppear")
    }

}
