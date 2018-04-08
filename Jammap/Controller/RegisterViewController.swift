//
//  RegisterViewController.swift
//  Jammap
//
//  Created by Sumu Pitchayan on 1/27/18.
//  Copyright © 2018 Sumu Pitchayan. All rights reserved.
//

import UIKit
import SVProgressHUD
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let background = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        background.image = UIImage(named: "lax.frat.jpg")
        background.contentMode = .scaleAspectFill
        background.alpha = 0.5
        view.addSubview(background)
        view.sendSubview(toBack: background)
    }

    @IBAction func registerPressed(_ sender: Any) {
        
        //TODO: Set up a new user on our Firbase database
        SVProgressHUD.show()
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            if error != nil {
                print(error!)
                SVProgressHUD.dismiss()
            } else {
                //Success
                print("Registration successful.")
                
                
                let usernamesDB = Database.database().reference().child("Usernames")
                let userDictionary = ["Email": Auth.auth().currentUser?.email,
                                      "Username": self.usernameTextField.text!]
                usernamesDB.childByAutoId().setValue(userDictionary) {
                    (error, reference) in
                    
                    if error != nil {
                        print(error!)
                    } else {
                        print("UserNAME saved successfully")
                    }
                
                
                /*
                let usernamesDB = Database.database().reference()
                let usernamesDictionary = ["Email": Auth.auth().currentUser?.email,
                                           "Username": self.usernameTextField.text!]
                usernamesDB.child("Users").setValue([self.usernameTextField.text! : usernamesDictionary]) {
                    (error, reference) in
                    
                    if error != nil {
                        print(error!)
                    } else {
                        print("Message saved successfully")
                    }
                */
                
                    
                }
                
                /*
                let usernameDB = Database.database().reference().child("Usernames")
                
                usernameDB.observe(.childAdded) { (snapshot) in
                    let snapshotValue = snapshot.value as! Dictionary<String, String>
                    let text = snapshotValue["UserID"]!
                    let sender = snapshotValue["Username"]!
                    
                    let message = Message()
                    message.messageBody = text
                    message.sender = sender
                    
                    self.messageArray.append(message)
                    
                    self.configureTableView()
                    self.messageTableView.reloadData()
                }
                */
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "registerToMain", sender: self)
            }
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
