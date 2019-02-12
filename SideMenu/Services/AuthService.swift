//
//  AuthService.swift
//  SideMenu
//
//  Created by Hiroshi Takemoto on 2/12/19.
//

import Foundation

class AuthService {
    
    static let shared = AuthService()
    private var user: User = User()
    var isAuthenticated: Bool = false
    
    init() {}
    
    func login(username: String, password: String) {
        user.setUser(firstName: "Steve", lastName: "Jobs", email: "steve.jobs@apple.com")
        isAuthenticated = true
    }
    
    func logout() {
        user.setUser(firstName: "", lastName: "", email: "")
        isAuthenticated = false
    }
    
    func getUserInfo() -> User {
        return user.getUser()
    }
}
