//
//  MenuItem.swift
//  SideMenu
//
//  Created by Hiroshi Takemoto on 3/2/18.
//

import Foundation

class MenuItem: NSObject {
    
    var displayName: String
    var icon: String
    var storyboard: String
    
    init(name: String, icon: String, storyboard: String) {
        self.displayName = name
        self.icon = icon
        self.storyboard = storyboard
        super.init()
    }
}
