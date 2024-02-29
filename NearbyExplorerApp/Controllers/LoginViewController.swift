//
//  LoginViewController.swift
//  NearbyExplorerApp
//
//  Created by Tringa on 2/17/24.
//

import UIKit
//import Firebase
class LoginViewController: UIViewController {
    let db = Databasehandler()
    @IBOutlet weak var tvEmail: UITextField!
    @IBOutlet weak var tvPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tvPassword.isSecureTextEntry = true
    }
    
    @IBAction func loginClicked(_ sender: UIButton) {
        let ans = db.loginAuthentication(email: tvEmail.text!, password: tvPassword.text!)
        if ans {
            let data = db.executeSelect(email: tvEmail.text!, password: tvPassword.text!)
            print(data.name)
            print(data.email)
            print(data.password)

            // Create an alert for successful login
            let successAlert = UIAlertController(title: "Login Successful", message: "Welcome, \(data.name)!", preferredStyle: .alert)

          
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.performSegue(withIdentifier: "goToNext", sender: self)
            })

            successAlert.addAction(okAction)

            //success alert
            self.present(successAlert, animated: true, completion: nil)
        } else {
            //alert for unsuccessful login
            let alert = UIAlertController(title: "Invalid Input", message: "Please enter correct email and password", preferredStyle: .alert)

            
            let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
            alert.addAction(dismissAction)

            // Present the alert
            self.present(alert, animated: true, completion: nil)
        }
    }



    
}
   

