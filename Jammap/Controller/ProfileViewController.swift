//
//  ProfileViewController.swift
//  Jammap
//
//  Created by Sumu Pitchayan on 1/27/18.
//  Copyright © 2018 Sumu Pitchayan. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    @IBOutlet weak var userPhotoImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userPhotoImageView.image = UIImage(cgImage: "userSC.png" as! CGImage)
        
        let eventsDB = Database.database().reference().child("Users")
        
        eventsDB.observeSingleEvent(of: .value, with: {snapshot in
            
            print(snapshot.childrenCount)
            
            for rest in snapshot.children.allObjects as! [DataSnapshot] {
                
                let usernameDictionary = rest.value as? NSDictionary
                
                let currentUserEmail = Auth.auth().currentUser?.email!
                self.usernameLabel.text = usernameDictionary?[currentUserEmail!] as! String
                
//                print(latitude)
//                print(longitude)
                
                //self.addEvent(lat: latitude, lon: longitude, title: title)
                
            }
        })

        // Do any additional setup after loading the view.
        
        self.navigationItem.hidesBackButton = true
        
        
        
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
