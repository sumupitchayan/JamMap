//
//  EventViewController.swift
//  Jammap
//
//  Created by Sumu Pitchayan on 1/28/18.
//  Copyright © 2018 Sumu Pitchayan. All rights reserved.
//

import UIKit

class EventViewController: UIViewController {

    var jamName: String = ""
    var location: String = ""
    var timeStart: String = ""
    var timeEnd: String = ""
    var notes: String = ""
    
    @IBOutlet weak var jamNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeStartLabel: UILabel!
    @IBOutlet weak var timeEndLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        jamNameLabel.text = jamName
        locationLabel.text = location
        timeStartLabel.text = timeStart
        timeEndLabel.text = timeEnd
        notesLabel.text = notes
        
    }

    @IBAction func backToMapPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "backToMap", sender: self)
        
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
