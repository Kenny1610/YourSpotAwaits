//
//  AppUser.swift
//  YourSpotAwaits
//
//  Created by Kendall McCaskill on 4/25/18.
//  Copyright © 2018 YourSpotAwaits. All rights reserved.
//

import Firebase

struct AppUser {
    var name: String?
    var uid: String?
    
    init?(snapshot: DataSnapshot) {
        guard let value = snapshot.value as? [String: Any] else { return }
        guard let name = value["name"] as? String else { return }
        self.name = name
    }
}
