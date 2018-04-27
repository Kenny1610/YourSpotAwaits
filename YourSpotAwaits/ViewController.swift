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
    
    let institutions = [Institutions(instituionName: "Northern Illinois University", institutionImage: #imageLiteral(resourceName: "NIU-72"))]
    
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
    
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Institutions"
        label.textAlignment = .center
        label.backgroundColor = UIColor.lightGray
        return label
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedInstitution = self.schools?[indexPath.row]
        
        let mapController = MapController()
        
        mapController.school = selectedInstitution
        
        let navController = UINavigationController(rootViewController: mapController)
        present(navController, animated: true, completion: nil)
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return institutions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! InstitutionCell
        
        let school = schools?[indexPath.row]
        cell.school = school
        
        cell.textLabel?.textColor = .black
        
        return cell
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

