//
//  HarperMapController.swift
//  YourSpotAwaits
//
//  Created by Kendall McCaskill on 4/28/18.
//  Copyright © 2018 YourSpotAwaits. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps
import Charts

class HarperController: UIViewController, GMSMapViewDelegate, ChartViewDelegate {
    
    let shapeLayer = CAShapeLayer()
    var mapView: GMSMapView?
    var school: Institutions?
    
    
    var tappedMarker: GMSMarker?
    var customInfoWindow = CorrectInfoWindow()
    
    
    
    let harperParkingLots = [ParkingLots(name: "Lot 1", location: CLLocationCoordinate2DMake(42.079247, -88.073280), zoom: 17, parkingSpaces: 280), ParkingLots(name: "Lot 3", location: CLLocationCoordinate2DMake(42.079096, -88.070238), zoom: 17, parkingSpaces: 210), ParkingLots(name: "Lot 4", location: CLLocationCoordinate2DMake(42.079729, -88.068401), zoom: 17, parkingSpaces: 250)]
    
    lazy var currentParkingLot = harperParkingLots[0]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let camera = GMSCameraPosition.camera(withLatitude: 42.079247, longitude: -88.073280, zoom: 17)
        mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView?.mapType = .satellite
        view = mapView
        
        let currentLocation = harperParkingLots.first?.location
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
        if let index = harperParkingLots.index(of: currentParkingLot) {
            currentParkingLot = harperParkingLots[index + 1]
            if currentParkingLot == harperParkingLots.last! {
                currentParkingLot = harperParkingLots.first!
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
        customInfoWindow.removeFromSuperview()
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
        
        if currentParkingLot.name == "Lot 1" {
            
            parkingSpots = arc4random_uniform(280) + 50
            customInfoWindow.fillChart(parkingData: ["Open": parkingSpots, "Total": UInt32(totalSpaces)])
            customInfoWindow.parkingLotTitleLabel.text = currentParkingLot.name
            customInfoWindow.parkingLotSpacesAvailable.text = "There are currently \(parkingSpots) available out of \(UInt32(totalSpaces)) total"
            
        } else if currentParkingLot.name == "Lot 2" {
            
            parkingSpots = arc4random_uniform(336)
            customInfoWindow.fillChart(parkingData: ["Open": parkingSpots, "Total": UInt32(totalSpaces)])
            customInfoWindow.parkingLotTitleLabel.text = currentParkingLot.name
            customInfoWindow.parkingLotSpacesAvailable.text = "There are currently \(parkingSpots) available out of \(UInt32(totalSpaces)) total"
            
        } else if currentParkingLot.name == "Lot 3" {
            
            parkingSpots = arc4random_uniform(210)
            customInfoWindow.fillChart(parkingData: ["Open": parkingSpots, "Total": UInt32(totalSpaces)])
            customInfoWindow.parkingLotTitleLabel.text = currentParkingLot.name
            customInfoWindow.parkingLotSpacesAvailable.text = "There are currently \(parkingSpots) available out of \(UInt32(totalSpaces)) total"
            
        } else if currentParkingLot.name == "Lot 4" {
            
            parkingSpots = arc4random_uniform(250)
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
extension CorrectInfoWindow {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        let index = highlight.y
        print("Selected \(index)")
    }
}
