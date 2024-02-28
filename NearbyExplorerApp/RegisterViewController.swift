//
//  RegisterViewController.swift
//  NearbyExplorerApp
//
//  Created by Tringa on 2/19/24.
//

import UIKit
import CryptoKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var tvName: UITextField!
    
    @IBOutlet weak var tvPassword: UITextField!
    @IBOutlet weak var tvEmail: UITextField!
    
    @IBOutlet weak var tvConfirmPassword: UITextField!
    let db = Databasehandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tvPassword.isSecureTextEntry = true  // Set secure text entry for password field
        tvConfirmPassword.isSecureTextEntry = true

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerClicked(_ sender: UIButton) {
        guard let email = tvEmail.text, !email.isEmpty,
              let password = tvPassword.text, !password.isEmpty,
              let confirmPassword = tvConfirmPassword.text, !confirmPassword.isEmpty,
              let name = tvName.text, !name.isEmpty else {
            // Show an alert for missing fields
            let missingFieldsAlert = UIAlertController(title: "Missing Fields", message: "Please fill in all the fields.", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
            missingFieldsAlert.addAction(dismissAction)
            self.present(missingFieldsAlert, animated: true, completion: nil)
            return
        }

        // Check if passwords match
        guard password == confirmPassword else {
            // Show an alert for mismatched passwords
            let mismatchAlert = UIAlertController(title: "Password Mismatch", message: "The password and confirm password fields do not match.", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
            mismatchAlert.addAction(dismissAction)
            self.present(mismatchAlert, animated: true, completion: nil)
            return
        }
        guard password.count >= 8 else {
                // Show an alert for insufficient password length
                let lengthAlert = UIAlertController(title: "Password Too Short", message: "Password must be at least 8 characters long.", preferredStyle: .alert)
                let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
                lengthAlert.addAction(dismissAction)
                self.present(lengthAlert, animated: true, completion: nil)
                return
            }


        // Check if the email already exists in the database
        let emailExists = db.doesEmailExist(email: email)

        if emailExists {
            // Email already exists, show an alert
            let duplicateEmailAlert = UIAlertController(title: "Duplicate Email", message: "This email is already registered. Please use a different email.", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
            duplicateEmailAlert.addAction(dismissAction)
            self.present(duplicateEmailAlert, animated: true, completion: nil)
        } else {
            // Email doesn't exist, proceed with registration
            do {
//                let hashedPassword = try hashPassword(password: password)
//                let q = "insert into logindata(name,email,password) values ('\(name)' , '\(email)' , '\(hashedPassword)')"
//                let result = db.executeQuery(query: q)
                let q = "insert into logindata(name,email,password) values ('\(name)' , '\(email)' , '\(password)')"
                           let result = db.executeQuery(query: q)
                if result {
                    // Successfully registered
                    let successAlert = UIAlertController(title: "Success", message: "Successfully registered!", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                        // Navigate to the login screen or perform any other actions after successful registration
                        self.performSegue(withIdentifier: "goToLogin", sender: self)
                    }
                    successAlert.addAction(okAction)
                    self.present(successAlert, animated: true, completion: nil)
                } else {
                    // Data not added (invalid input)
                    let invalidAlert = UIAlertController(title: "Invalid Input", message: "Please check your input and try again.", preferredStyle: .alert)
                    let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
                    invalidAlert.addAction(dismissAction)
                    self.present(invalidAlert, animated: true, completion: nil)
                }
            }
//            catch {
//                print("Error hashing password: \(error)")
//            }
        }
    }

//    func hashPassword(password: String) throws -> String {
//            let passwordData = Data(password.utf8)
//            let hashed = SHA256.hash(data: passwordData)
//            return hashed.compactMap { String(format: "%02x", $0) }.joined()
//        }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
