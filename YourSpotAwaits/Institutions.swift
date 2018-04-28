//
//  Institutions.swift
//  YourSpotAwaits
//
//  Created by Kendall McCaskill on 4/4/18.
//  Copyright © 2018 YourSpotAwaits. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class Institutions {
    let institutionName: String
    var institutionImage: UIImage
    let parkingLots: [ParkingLots]
    
    
    init(instituionName: String, institutionImage: UIImage, parkingLots: [ParkingLots]) {
        self.institutionName = instituionName
        self.institutionImage = institutionImage
        self.parkingLots = parkingLots
    }
    
}

class ParkingLots: NSObject {
    let name: String
    let location: CLLocationCoordinate2D
    let zoom: Float
    let parkingSpaces: Int
    
    init(name: String, location: CLLocationCoordinate2D, zoom: Float, parkingSpaces: Int) {
        self.name = name
        self.location = location
        self.zoom = zoom
        self.parkingSpaces = parkingSpaces
    }
    
    
}
