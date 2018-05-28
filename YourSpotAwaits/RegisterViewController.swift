//
//  RegisterViewController.swift
//  YourSpotAwaits
//
//  Created by Kendall McCaskill on 4/14/18.
//  Copyright © 2018 YourSpotAwaits. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase



class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    let myColor = UIColor.black
    
    //Creating Image View with closure
    let titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "YSA-76")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
//    //Create textfield for username
//    let userName: UITextField = {
//        let user = UITextField()
//        user.translatesAutoresizingMaskIntoConstraints = false
//        user.placeholder = "Enter your User Name"
//        user.backgroundColor = .clear
//        user.textColor = .black
//        user.borderStyle = .roundedRect
//        user.keyboardType = .default
//        return user
//    }()
    
    //Creating password Textfield with closure
    let passWord: UITextField = {
        let p = UITextField()
        p.translatesAutoresizingMaskIntoConstraints = false
        p.placeholder = "Enter New Password"
        p.backgroundColor = .clear
        p.textColor = .black
        p.isSecureTextEntry = true
        p.borderStyle = .roundedRect
        p.keyboardType = .default
        return p
    }()
    
    //Creating Repeat Password texfield with closure
    let confirmPassword: UITextField = {
        let p = UITextField()
        p.translatesAutoresizingMaskIntoConstraints = false
        p.placeholder = "Confirm Password"
        p.backgroundColor = .clear
        p.textColor = .black
        p.isSecureTextEntry = true
        p.borderStyle = .roundedRect
        p.keyboardType = .default
        return p
    }()
    
    let emailField: UITextField = {
        let mail = UITextField()
        mail.translatesAutoresizingMaskIntoConstraints = false
        mail.placeholder = "Enter Your Email Address"
        mail.backgroundColor = .clear
        mail.borderStyle = .roundedRect
        mail.layer.borderColor = UIColor.black.cgColor
        mail.textColor = .black
        mail.keyboardType = .emailAddress
        return mail
    }()
    
    let nameField: UITextField = {
       let name = UITextField()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.placeholder = "Enter Your Name"
        name.backgroundColor = .clear
        name.borderStyle = .roundedRect
        name.layer.borderColor = UIColor.black.cgColor
        name.textColor = .black
        name.keyboardType = .default
        return name
    }()
    
    let parkingPassLabel: UILabel = {
       let pass = UILabel()
        pass.translatesAutoresizingMaskIntoConstraints = false
        pass.text = "Please select the color of your parking pass."
        pass.textAlignment = .center
        pass.font = .systemFont(ofSize: 14)
        pass.textColor = .black
        
        return pass
    }()
    
    let parkingPassSegmentedControl: UISegmentedControl = {
        let pass = UISegmentedControl()
        pass.translatesAutoresizingMaskIntoConstraints = false
        pass.insertSegment(withTitle: "Yellow", at: 0, animated: true)
        pass.insertSegment(withTitle: "Blue", at: 1, animated: true)
        return pass
    }()
    
    //Creating Register button with closure
    let registerButton: UIButton = {
        let register = UIButton()
        register.translatesAutoresizingMaskIntoConstraints = false
        register.setTitle("Register", for: .normal)
        register.addTarget(self, action: #selector(registerUser(button:)), for: .touchUpInside)
        register.backgroundColor = UIColor.gray
        register.layer.cornerRadius = 5
        register.layer.borderWidth = 1
        register.layer.borderColor = UIColor.black.cgColor
        return register
    }()
    
//    let messageLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .black
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = .clear
//        label.layer.borderColor = UIColor.black.cgColor
//        label.layer.cornerRadius = 5
//        label.layer.borderWidth = 1
//        return label
//    }()
    
    override func viewDidLoad() {
        setupViews()
        //This will move the view up so the keyboard will not block the TextFields
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    fileprivate func setupViews() {
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Login", style: .plain, target: self, action: #selector(goLogin))
        
        //Add the Textfields and Button to the view
        view.addSubview(titleImageView)
//        view.addSubview(userName)
        view.addSubview(emailField)
        view.addSubview(passWord)
        view.addSubview(confirmPassword)
        view.addSubview(parkingPassLabel)
        view.addSubview(parkingPassSegmentedControl)
        view.addSubview(nameField)
        view.addSubview(registerButton)
//        view.addSubview(messageLabel)
        
        
         //Constraints for Your Spot Awaits Image View
        titleImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleImageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 15).isActive = true
        titleImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        titleImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
     
        
        //Constraints for the Username Text Field
//        userName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        userName.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 180).isActive = true
//        userName.widthAnchor.constraint(equalToConstant: 300).isActive = true
//        userName.heightAnchor.constraint(equalToConstant: 50).isActive = true
//
        //Constraints for the email Text Field
        emailField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailField.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 180).isActive = true
        emailField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        emailField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //Constraints for the Password Text Field
        passWord.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passWord.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 15).isActive = true
        passWord.widthAnchor.constraint(equalToConstant: 300).isActive = true
        passWord.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        confirmPassword.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        confirmPassword.topAnchor.constraint(equalTo: passWord.bottomAnchor, constant: 15).isActive = true
        confirmPassword.widthAnchor.constraint(equalToConstant: 300).isActive = true
        confirmPassword.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        //Constraints for the email Text Field
//        emailField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        emailField.topAnchor.constraint(equalTo: repeatPassword.bottomAnchor, constant: 15).isActive = true
//        emailField.widthAnchor.constraint(equalToConstant: 300).isActive = true
//        emailField.heightAnchor.constraint(equalToConstant: 50).isActive = true
       
        
        //Constraints for the nameField Text Field
        nameField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameField.topAnchor.constraint(equalTo: confirmPassword.bottomAnchor, constant: 15).isActive = true
        nameField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        nameField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        parkingPassLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        parkingPassLabel.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 8).isActive = true
        parkingPassLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        parkingPassLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        parkingPassSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        parkingPassSegmentedControl.topAnchor.constraint(equalTo: parkingPassLabel.bottomAnchor, constant: 15).isActive = true
        parkingPassSegmentedControl.widthAnchor.constraint(equalToConstant: 200).isActive = true
        parkingPassSegmentedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        if (parkingPassSegmentedControl.selectedSegmentIndex == 0) {
            parkingPassSegmentedControl.tintColor = .yellow
        } else if (parkingPassSegmentedControl.selectedSegmentIndex == 1) {
            parkingPassSegmentedControl.tintColor = .blue
        }
        
        //Constraints for the register Button
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: parkingPassSegmentedControl.bottomAnchor, constant: 15).isActive = true
        registerButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
      
        
        //Constraints for the Message Label
//        messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        messageLabel.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 15).isActive = true
//        messageLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
//        messageLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
//        userName.delegate = self
        passWord.delegate = self
        confirmPassword.delegate = self
        emailField.delegate = self
        nameField.delegate = self

        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

    
    
    //MARK
    //This Button is processing the information to the backend server.
    @objc func registerUser(button: UIButton) {
        
        guard let password = passWord.text else { return }
        guard let email = emailField.text else { return }
        guard let name = nameField.text else { return }

        
        // Validate required fields are not empty
        if (password.isEmpty) || (email.isEmpty) || (name.isEmpty) {
            
            // Display Alert message and return
            displayMessage(userMessage: "All fields are required to fill in")
            return
        }
        
        // Validate password and Repeat Password are the same
        if ((passWord.text?.elementsEqual(confirmPassword.text!))! != true) {
            
            // Display alert message
            displayMessage(userMessage: "Please make sure that passwords match")
            return
        }
        
        FirebaseAPI.shared.signUp(email: email, password: password, name: name) { [weak self] (err) in
            if err != nil {
                //show alert
                self?.displayMessage(userMessage: "Unable to register you correctly. Please try again.")
                print(err?.localizedDescription as Any)
            } else {
                self?.dismiss(animated: true, completion: nil)
            }
        }
        
    
        //Create Activity Indicator
        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        
        // Position Activity Indicator in the center of the main view
        myActivityIndicator.center = view.center
        
        //If needed, you can prevent Activity Indicator from hiding when stopAnimating() is called
        myActivityIndicator.hidesWhenStopped = false
        
        // Start Activity Indicator
        myActivityIndicator.startAnimating()
        
        view.addSubview(myActivityIndicator)
        
        self.view.endEditing(true)
    }
    
  

    
    
    
    
    //This method removes the activity indicator from view
    func removeActivityIndicator(activityIndicator: UIActivityIndicatorView) {
        DispatchQueue.main.async {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
    
    func displayMessage(userMessage: String) -> Void {
        DispatchQueue.main.async {
            // Display Alert message and return
            let alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default) {( handler: UIAlertAction) in
                //Code in this blick will trigger when OK button tapped.
                DispatchQueue.main.async {
//                    self.dismiss(animated: true, completion: nil)
                }
        }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -150 //Move view 150 points upward
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0 //Move the view to original position
    }
    
    @objc func goLogin() {
        
        let loginController = LoginViewController()
        
        let navigationController = UINavigationController(rootViewController: loginController)
        present(navigationController, animated: true, completion: nil)
    }
    
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
}

