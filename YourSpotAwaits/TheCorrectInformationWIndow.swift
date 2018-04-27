//
//  TheCorrectInformationWIndow.swift
//  YourSpotAwaits
//
//  Created by Kendall McCaskill on 4/4/18.
//  Copyright © 2018 YourSpotAwaits. All rights reserved.
//

import UIKit
import Foundation


class TheCorrectInformationWindow: UIView {
    
    var newParkingLotLabel: UILabel = UILabel()
    var carsInParkingLot: UILabel = UILabel()
    //    var newAnimationView: UIView = UIView()
    //    var circleView: UIView = UIView()
    
    
    
 
    
    var parkingSpots = 0
    
    var parkingInfo: InformationWindow? {
        didSet {
            if parkingSpots < (80 / 4) {
                self.backgroundColor = .green
            }
            else if parkingSpots > 20 && parkingSpots < 50 {
                self.backgroundColor = .yellow
            } else if parkingSpots > 50 && parkingSpots < 80 {
                self.backgroundColor = .red
            }
        }
    }
    
    
    
    //Initialize the frames for the the information window
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 6
        
        newParkingLotLabel.textColor = .black
        newParkingLotLabel.numberOfLines = 1
        newParkingLotLabel.textAlignment = .left
        newParkingLotLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(newParkingLotLabel)
        
        carsInParkingLot.textColor = .black
        carsInParkingLot.numberOfLines = 1
        carsInParkingLot.textAlignment = .left
        carsInParkingLot.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(carsInParkingLot)
        
        
        
        newParkingLotLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8)
        newParkingLotLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5)
        carsInParkingLot.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8)
        carsInParkingLot.topAnchor.constraint(equalTo: newParkingLotLabel.topAnchor, constant: 8)
        
        //        self.addSubview(newAnimationView)
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    

    
    @objc func addSpots() -> Int {
        parkingSpots += 1
        return parkingSpots
    }
    
    @objc func subtractParkingSpaces() -> Int {
        parkingSpots -= 1
        return parkingSpots
    }
    
    
    
    
    
    
}

