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
        if tvEmail.text! != "" && tvPassword.text! != ""{
            var q = "insert into logindata(name,email,password) values ('"+tvName.text!+"' , '"+tvEmail.text!+"' , '"+tvPassword.text!+"')"
            let result = db.executeQuery(query: q)
            
            if result{
                self.performSegue(withIdentifier: "goToNext", sender: self)
            }
            else{
                print("Data not Added")
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
