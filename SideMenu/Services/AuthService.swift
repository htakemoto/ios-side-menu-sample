//
//  AuthService.swift
//  SideMenu
//
//  Created by Hiroshi Takemoto on 2/12/19.
//

import Foundation

class AuthService {
    
    // MARK: Properties
    
    static let shared = AuthService()
    var user: User {
        get {
            let firstName = Preferences.firstName
            let lastName = Preferences.lastName
            let email = Preferences.email
            return User(firstName: firstName, lastName: lastName, email: email)
        }
        set {
            Preferences.firstName = newValue.firstName
            Preferences.lastName = newValue.lastName
            Preferences.email = newValue.email
        }
    }
    var isAuthenticated: Bool = false
    
    init() {}
    
    // MARK: Public Methods
    
    func login(username: String, password: String) {
        self.user = User(firstName: "Steve", lastName: "Jobs", email: "steve.jobs@apple.com")
        isAuthenticated = true
    }
    
    func logout() {
        self.user = User(firstName: "", lastName: "", email: "")
        isAuthenticated = false
    }
    
    func getUserInfo() -> User {
        return user
    }
    
    func updateUserInfo(_ user: User) {
        self.user = User(firstName: user.firstName, lastName: user.lastName, email: user.email)
    }
}
