//
//  RegisterViewController.swift
//  NearbyExplorerApp
//
//  Created by Tringa on 2/19/24.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var tvName: UITextField!
    
    @IBOutlet weak var tvPassword: UITextField!
    @IBOutlet weak var tvEmail: UITextField!
    
    let db = Databasehandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerClicked(_ sender: UIButton) {
        if tvEmail.text! != "" && tvPassword.text! != "" {
            // Check if the email already exists in the database
            let emailExists = db.doesEmailExist(email: tvEmail.text!)

            if emailExists {
                // Email already exists, show an alert
                let duplicateEmailAlert = UIAlertController(title: "Duplicate Email", message: "This email is already registered. Please use a different email.", preferredStyle: .alert)
                let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
                duplicateEmailAlert.addAction(dismissAction)
                self.present(duplicateEmailAlert, animated: true, completion: nil)
            } else {
                // Email doesn't exist, proceed with registration
                let q = "insert into logindata(name,email,password) values ('"+tvName.text!+"' , '"+tvEmail.text!+"' , '"+tvPassword.text!+"')"
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
        }
    }


    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
