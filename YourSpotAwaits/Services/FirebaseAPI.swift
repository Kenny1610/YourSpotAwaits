//
//  FirebaseAPI.swift
//  YourSpotAwaits
//
//  Created by Kendall McCaskill on 4/25/18.
//  Copyright © 2018 YourSpotAwaits. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

struct FirebaseAPI {
    static let shared = FirebaseAPI()
    
    private init() {
        
    }
    
    private let ref = Database.database().reference()
    
    var userID: String? {
        get {
            return Auth.auth().currentUser?.uid
        }
    }
    
    //We are escaping this function because once the completion handler is executed, we want it to escape the scope of the closure.
    func signUp(email: String, password: String, name: String, completionHandler: @escaping (Error?) -> Void) {
        let userData: [String: Any] = ["name": name]
        
        Auth.auth().createUserAndRetrieveData(withEmail: email, password: password) { (result, error) in
            if let err = error {
                print(err.localizedDescription)
                completionHandler(err)
            } else {
                guard let uid = result?.user.uid else { return }
                self.ref.child("users/\(uid)").setValue(userData)
                UserDefaultsManager.shared.userIsLoggedIn = false
                print("Succesfully created a user:", uid)
                completionHandler(nil)
            }
        }
    }

    func logOut(completionHandler: (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            UserDefaultsManager.shared.userIsLoggedIn = false
            completionHandler(nil)
            print("Successfully logged out")
        } catch let err {
            print(err.localizedDescription)
            completionHandler(err)
        }
    }

func logIn(email: String, password: String, completionHandler: @escaping (Error?) -> Void) {
    Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
        if let err = error {
            completionHandler(err)
        } else {
            guard let uid = user?.uid else { return }
            print("User: \(uid) is logged in successfully")
            UserDefaultsManager.shared.userIsLoggedIn = true
            completionHandler(nil)
        }
    }
}



func fetch(completionHandler: @escaping (AppUser?) -> Void) {
    guard let userId = userID else { return }
    ref.child("users").child(userId).observeSingleEvent(of: .value) { (snapshot) in
        let appUser = AppUser(snapshot: snapshot)
        completionHandler(appUser)
        print("Successfully fetched user info")
    }
}

}

    


