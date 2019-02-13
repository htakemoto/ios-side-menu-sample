//
//  Preferences.swift
//  SideMenu
//
//  Created by Hiroshi Takemoto on 2/16/19.
//

import Foundation

struct Preferences {
    
    static var firstName: String {
        get { return UserDefaults.standard.string(forKey: #function) ?? "" }
        set { UserDefaults.standard.set(newValue, forKey: #function) }
    }
    
    static var lastName: String {
        get { return UserDefaults.standard.string(forKey: #function) ?? "" }
        set { UserDefaults.standard.set(newValue, forKey: #function) }
    }
    
    static var email: String {
        get { return UserDefaults.standard.string(forKey: #function) ?? "" }
        set { UserDefaults.standard.set(newValue, forKey: #function) }
    }
}
