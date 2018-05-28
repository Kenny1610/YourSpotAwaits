//
//  MapController.swift
//  YourSpotAwaits
//
//  Created by Kendall McCaskill on 4/4/18.
//  Copyright © 2018 YourSpotAwaits. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps
import Charts

class MapController: UIViewController, GMSMapViewDelegate, ChartViewDelegate {
    
    let shapeLayer = CAShapeLayer()
    var mapView: GMSMapView?
    var school: Institutions?
    
    
    var tappedMarker: GMSMarker?
    var customInfoWindow = CorrectInfoWindow()

    
    
    let collegeParkingLots = [ParkingLots(name: "NIU Parking Deck", location: CLLocationCoordinate2DMake(41.932347, -88.766415), zoom: 16.0, parkingSpaces: 969), ParkingLots(name: "Parking Lot C", location: CLLocationCoordinate2DMake(41.935683, -88.771528), zoom: 16.0, parkingSpaces: 109), ParkingLots(name: "Parking Lot 2", location: CLLocationCoordinate2DMake(41.936876, -88.762379), zoom: 16.0, parkingSpaces: 261), ParkingLots(name: "Parking Lot A", location: CLLocationCoordinate2DMake(41.939165, -88.760849), zoom: 16.0, parkingSpaces: 85)]

    lazy var currentParkingLot = collegeParkingLots[0]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let camera = GMSCameraPosition.camera(withLatitude: 41.932347, longitude: -88.766415, zoom: 16.0)
        mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView?.mapType = .satellite
        view = mapView
        
        let currentLocation = collegeParkingLots.first?.location
        let marker = GMSMarker(position: currentLocation!)
        marker.snippet = currentParkingLot.name
        marker.map = mapView
        
        navigationItem.title = self.school?.institutionName
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(newLocation))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
        
        mapView?.delegate = self
        customInfoWindow = loadNib()
        
    }
    
    
    func setupNavigationBarStyles() {
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 150/255, green: 0/255, blue: 0/255, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    
    @objc func newLocation() {
            if let index = collegeParkingLots.index(of: currentParkingLot) {
                currentParkingLot = collegeParkingLots[index + 1]
                if currentParkingLot == collegeParkingLots.last! {
                    currentParkingLot = collegeParkingLots.first!
                }
            }
        
        setMapCamera()
    }
    
    @objc func goBack() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setMapCamera() {
        CATransaction.begin()
        CATransaction.setValue(1.2, forKey: kCATransactionAnimationDuration)
        mapView?.animate(to: GMSCameraPosition.camera(withTarget: currentParkingLot.location, zoom: currentParkingLot.zoom))
        CATransaction.commit()
        customInfoWindow.removeFromSuperview()
        
        let marker = GMSMarker(position: currentParkingLot.location)
        marker.title = currentParkingLot.name
        marker.map = mapView

    }
    
    
    
    override func loadView() {
        customInfoWindow = loadNib()
    }
    
    
    // MARK:
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        return UIView()
    }
    
    
    //Reset custom infoWindow whenever marker is tapped
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        tappedMarker = marker
        

        
        let position = tappedMarker?.position
        mapView.animate(toLocation: position!)
        let point = mapView.projection.point(for: position!)
        let newPoint = mapView.projection.coordinate(for: point)
        let camera = GMSCameraUpdate.setTarget(newPoint)
        mapView.animate(with: camera)
        
        let totalSpaces = currentParkingLot.parkingSpaces
        let parkingSpots: UInt32
        
        //Create custom info Window
//        customInfoWindow.removeFromSuperview()
        customInfoWindow = loadNib()
        customInfoWindow.center = mapView.projection.point(for: position!)
        //-=192 is the value to use to put the view on top of the marker
        customInfoWindow.center.y += 160
        self.view.addSubview(customInfoWindow)
        customInfoWindow.setupPieChart()

        let opaqueWhite = UIColor(white: 1, alpha: 0.85)
        customInfoWindow.layer.backgroundColor = opaqueWhite.cgColor
        customInfoWindow.layer.cornerRadius = 8
        customInfoWindow.backgroundColor = .white
        
        if currentParkingLot.name == "NIU Parking Deck" {
            
        parkingSpots = arc4random_uniform(969) + 50
            customInfoWindow.fillChart(parkingData: ["Open": parkingSpots, "Total": UInt32(totalSpaces)])
        customInfoWindow.parkingLotTitleLabel.text = currentParkingLot.name
        customInfoWindow.parkingLotSpacesAvailable.text = "There are currently \(parkingSpots) available out of \(UInt32(totalSpaces)) total"
            
        } else if currentParkingLot.name == "Parking Lot C" {
            
            parkingSpots = arc4random_uniform(109)
            customInfoWindow.fillChart(parkingData: ["Open": parkingSpots, "Total": UInt32(totalSpaces)])
            customInfoWindow.parkingLotTitleLabel.text = currentParkingLot.name
            customInfoWindow.parkingLotSpacesAvailable.text = "There are currently \(parkingSpots) available out of \(UInt32(totalSpaces)) total"
            
        } else if currentParkingLot.name == "Parking Lot 2" {
            
            parkingSpots = arc4random_uniform(261)
            customInfoWindow.fillChart(parkingData: ["Open": parkingSpots, "Total": UInt32(totalSpaces)])
            customInfoWindow.parkingLotTitleLabel.text = currentParkingLot.name
            customInfoWindow.parkingLotSpacesAvailable.text = "There are currently \(parkingSpots) available out of \(UInt32(totalSpaces)) total"
            
        } else if currentParkingLot.name == "Parking Lot A" {
            
            parkingSpots = arc4random_uniform(85)
            customInfoWindow.parkingLotTitleLabel.text = currentParkingLot.name
            customInfoWindow.parkingLotSpacesAvailable.text = "There are currently \(parkingSpots) available out of \(UInt32(totalSpaces)) total"
        }
        
        //Return false so marker event is still handled by delegate
        return false
    }
    
    //Let custom info window follow the camera
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        if tappedMarker?.position != nil {
            let position = tappedMarker?.position
            customInfoWindow.center = mapView.projection.point(for: position!)
            customInfoWindow.center.y -= 140
        }
        
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        customInfoWindow.removeFromSuperview()
    }
    
    // MARK: Needed to create the custom info window (this is optional)
    func sizeForOffset(view: UIView) -> CGFloat {
        return  135.0
    }
    
    func loadNib() -> CorrectInfoWindow {
        let infoWindow = customInfoWindow.instanceFromNib() as! CorrectInfoWindow
        return infoWindow
    }
    
}

    

    


