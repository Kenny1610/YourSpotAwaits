//
//  LoginViewController.swift
//  YourSpotAwaits
//
//  Created by Kendall McCaskill on 4/6/18.
//  Copyright © 2018 YourSpotAwaits. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class LoginViewController: UIViewController, UITextFieldDelegate {
    
    
    //Creating Image View with closure
    let titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "Icon-72")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    
    //Create textfield for username
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
    
    //Creating password Textfield with closure
    let passWord: UITextField = {
        let p = UITextField()
        p.translatesAutoresizingMaskIntoConstraints = false
        p.placeholder = "Enter Password"
        p.backgroundColor = .clear
        p.textColor = .black
        p.borderStyle = .roundedRect
        p.keyboardType = .default
        p.isSecureTextEntry = true
        return p
    }()
    
    
    //Creating login button with closure
    let loginButton: UIButton = {
       let login = UIButton()
        login.translatesAutoresizingMaskIntoConstraints = false
        login.setTitle("Login", for: .normal)
        login.addTarget(self, action: #selector(completeLogin), for: .touchUpInside)
        login.backgroundColor = UIColor.gray
        login.layer.cornerRadius = 5
        login.layer.borderWidth = 1
        login.layer.borderColor = UIColor.black.cgColor
        return login
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
    
    
    
    
//    //Create forgot password button
//    let forgotPassword: UIButton = {
//        let forgot = UIButton()
//        forgot.translatesAutoresizingMaskIntoConstraints = false
//        forgot.setTitle("Forgot Password", for: .normal)
//        return forgot
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        
        //This will move the view up so the keyboard will not block the TextFields
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    fileprivate func setupViews() {
        view.backgroundColor = .white
        
        //Add the TextFields and Login Button to the view
        view.addSubview(titleImageView)
//        view.addSubview(userName)
        view.addSubview(emailField)
        view.addSubview(passWord)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
        
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
        
        //Constraints for the register Button
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: passWord.bottomAnchor, constant: 15).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //Constraints for the register Button
        view.addSubview(registerButton)
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 15).isActive = true
        registerButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
//        userName.delegate = self
        emailField.delegate = self
        passWord.delegate = self
        
    }
    
    @objc func completeLogin() {
        guard let email = emailField.text else { return }
        guard let password = passWord.text else { return }
        
        FirebaseAPI.shared.logIn(email: email, password: password) { [weak self] (err) in
            if err != nil {
                //show error alert
                self?.displayMessage(userMessage: "Unable to log you in. Please try again.")
            } else {
                self?.showSchoolsViewController()
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
                    //                    self.dismiss(animated: true, completion: nil)
                }
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showSchoolsViewController() {
        //Show The Schools
        let navController = UINavigationController(rootViewController: ViewController())
        self.present(navController, animated: true, completion: nil)
    }
    
    @objc func registerUser(button: UIButton) {
        let registerController = RegisterViewController()
        
        let navController = UINavigationController(rootViewController: registerController)
        present(navController, animated: true, completion: nil)
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -50 //Move view 150 points upward
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0 //Move the view to original position
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
}

