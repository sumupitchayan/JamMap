//
//  WelcomeViewController.swift
//  Jammap
//
//  Created by Sumu Pitchayan on 1/27/18.
//  Copyright © 2018 Sumu Pitchayan. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let background = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        background.image = UIImage(named: "lax.gates.jpg")
        background.contentMode = .scaleAspectFill
        view.addSubview(background)
        view.sendSubview(toBack: background)
        
        /*
        let backgroundPic = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        backgroundPic.image = UIImage(contentsOfFile: "lax.gates.png")
        view.addSubview(backgroundPic)
         */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logInPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToLogin", sender: sender)
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToRegister", sender: sender)
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
