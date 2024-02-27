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
        // Do any additional setup after loading the view.
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

            // You might want to add an action to the alert, for example, a "OK" button
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                // Perform any additional actions after successful login if needed
                self.performSegue(withIdentifier: "goToNext", sender: self)
            })

            successAlert.addAction(okAction)

            // Present the success alert
            self.present(successAlert, animated: true, completion: nil)
        } else {
            // Create an alert for unsuccessful login
            let alert = UIAlertController(title: "Invalid Input", message: "Please enter correct email and password", preferredStyle: .alert)

            // You might want to add an action to the alert, for example, a "Dismiss" button
            let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
            alert.addAction(dismissAction)

            // Present the alert
            self.present(alert, animated: true, completion: nil)
        }
    }


//        guard let email = emailTextField.text else {return}
//        guard let password = passwordTextField.text else {return}
        
        //implement firebase
//        Auth.auth().signIn(withEmail: email, password: password) {firebaseResult, error in
//            if let e = error{
//                print("error")
//            } else {
//                //go to homescreen
//                self.performSegue(withIdentifier: "goToNext", sender: self)
//            }
            
//        }
    
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


