//
//  LoginViewController.swift
//  FinalProject
//
//  Created by David van der Velden on 10/12/2017.
//  Copyright © 2017 David van der Velden. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuthUI
import FirebaseDatabase

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser != nil {
            // User is signed in.
            print("user is signed in")
            self.performSegue(withIdentifier: "LoginToList", sender: nil)
        } else {
            print("not logged in")
            // No user is signed in.
        }

    }
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func unwindToLogin(segue: UIStoryboardSegue) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func loginPressed(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: userNameTextField.text!,
                           password: passwordTextField.text!) { (user, error) in
                            self.performSegue(withIdentifier: "LoginToList", sender: nil)
        }
        
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Register",
                                      message: "Register",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) { action in
                                        
                                        let emailField = alert.textFields![0]
                                        let passwordField = alert.textFields![1]
                                        
                                        Auth.auth().createUser(withEmail: emailField.text!,
                                                                   password: passwordField.text!) { user, error in
                                                                    if error == nil {
                                                                        Auth.auth().signIn(withEmail: self.userNameTextField.text!,
                                                                                               password: self.passwordTextField.text!)
                                                                    } else { print(error) }
                                        }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField { textEmail in
            textEmail.placeholder = "Enter your email"
        }
        
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
}
