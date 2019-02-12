//
//  User.swift
//  SideMenu
//
//  Created by Hiroshi Takemoto on 2/12/19.
//

import Foundation

class User {
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    private let userDefaults = UserDefaults.standard
    
    init() {}
    
    func getUser() -> User {
        self.firstName = userDefaults.string(forKey: "user.firstName")!
        self.lastName = userDefaults.string(forKey: "user.lastName")!
        self.email = userDefaults.string(forKey: "user.email")!
        return self
    }
    
    func setUser(firstName: String, lastName: String, email: String) {
        userDefaults.set(firstName, forKey: "user.firstName")
        userDefaults.set(lastName, forKey: "user.lastName")
        userDefaults.set(email, forKey: "user.email")
    }
}
