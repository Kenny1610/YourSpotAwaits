//
//  UserDefaultsManager.swift
//  YourSpotAwaits
//
//  Created by Kendall McCaskill on 4/25/18.
//  Copyright © 2018 YourSpotAwaits. All rights reserved.
//

import Foundation

struct Constants {
    struct Authentication {
        static let userIsLoggedIn = "UserIsLoggedIn"
    }
    
    private init() {
        
    }
}


class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    private init() {
        
    }
    
    var userIsLoggedIn: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Constants.Authentication.userIsLoggedIn)
        }
        set {
            return UserDefaults.standard.set(newValue, forKey: Constants.Authentication.userIsLoggedIn)
        }
    }
}
