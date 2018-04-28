//
//  ViewController.swift
//  YourSpotAwaits
//
//  Created by Kendall McCaskill on 4/4/18.
//  Copyright © 2018 YourSpotAwaits. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleMaps
import GooglePlaces



class ViewController: UITableViewController {
    
    var appUser: AppUser? {
        didSet {
            print("value set")
            guard let userName = appUser?.name else { return }
            navigationItem.title = "Schools available for you \(userName)"
        }
    }
    
    
    let cellId = "cellId"
    
    var schools: [Institutions]?
    
    let institutions = [Institutions(instituionName: "Northern Illinois University", institutionImage: #imageLiteral(resourceName: "NIU-72"), parkingLots: [ParkingLots(name: "NIU Parking Deck", location: CLLocationCoordinate2DMake(41.932347, -88.766415), zoom: 16.0, parkingSpaces: 969), ParkingLots(name: "Parking Lot C", location: CLLocationCoordinate2DMake(41.935683, -88.771528), zoom: 16.0, parkingSpaces: 109), ParkingLots(name: "Parking Lot 2", location: CLLocationCoordinate2DMake(41.936876, -88.762379), zoom: 16.0, parkingSpaces: 261), ParkingLots(name: "Parking Lot A", location: CLLocationCoordinate2DMake(41.939165, -88.760849), zoom: 16.0, parkingSpaces: 85)]), Institutions(instituionName: "Harper College", institutionImage: #imageLiteral(resourceName: "Harper-73"), parkingLots: [ParkingLots(name: "Lot 1", location: CLLocationCoordinate2DMake(42.079247, -88.073280), zoom: 16, parkingSpaces: 280), ParkingLots(name: "Lot 2", location: CLLocationCoordinate2DMake(42.079108, -88.071447), zoom: 16, parkingSpaces: 336), ParkingLots(name: "Lot 3", location: CLLocationCoordinate2DMake(42.079096, -88.070238), zoom: 16, parkingSpaces: 210), ParkingLots(name: "Lot 4", location: CLLocationCoordinate2DMake(42.079729, -88.068401), zoom: 16, parkingSpaces: 250)])]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        navigationItem.title = "Your Spot Awaits"
        navigationController?.navigationBar.prefersLargeTitles = true
        
         navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(goLogout))
        
        
        
        
        tableView.register(InstitutionCell.self, forCellReuseIdentifier: cellId )
        
    }
    
    func setupNavigationBarStyles() {
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    
    
    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let label = UILabel()
//        label.text = "Institutions"
//        label.textAlignment = .center
//        label.backgroundColor = UIColor.lightGray
//        return label
//    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedInstitution = self.schools?[indexPath.row]
        if indexPath.row == 0 {
        let mapController = MapController()
        
        mapController.school = selectedInstitution
        
        let navController = UINavigationController(rootViewController: mapController)
        present(navController, animated: true, completion: nil)
        } else if indexPath.row == 1 {
            let harperMapController = HarperController()
            harperMapController.school = selectedInstitution
            
            let navController = UINavigationController(rootViewController: harperMapController)
            present(navController, animated: true, completion: nil)
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! InstitutionCell
        
        let school = institutions[indexPath.row]
        cell.textLabel?.text = school.institutionName
        cell.imageView?.image = school.institutionImage
        cell.textLabel?.textColor = .black
            
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }
    

    
    @objc func goLogout() {
        FirebaseAPI.shared.logOut {[weak self] (err) in
            if err != nil {
                //show alert
                print(err?.localizedDescription)
            } else {
                self?.showLoginController()
            }
        }
        
    }
    
    func showLoginController() {
        let loginController = UINavigationController(rootViewController: LoginViewController())
        present(loginController, animated: true, completion: nil)
    }
    
    func fetchUserInfo() {
        FirebaseAPI.shared.fetch { [weak self] (user) in
            if user != nil {
                self?.appUser = user
            }
        }
    }
    
    func displayMessage(userMessage: String) -> Void {
        DispatchQueue.main.async {
            // Display Alert message and return
            let alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default) {( handler: UIAlertAction) in
                //Code in this blick will trigger when OK button tapped.
                DispatchQueue.main.async {

                }
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }

}

