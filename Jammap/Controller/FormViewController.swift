//
//  FormViewController.swift
//  Jammap
//
//  Created by Sumu Pitchayan on 1/27/18.
//  Copyright © 2018 Sumu Pitchayan. All rights reserved.
//

import UIKit
import Firebase
import MapKit

class FormViewController: UIViewController {
    
    var host = ""
    var timeStart = ""
    var timeEnd = ""
    //var title: String = String()
    var location: String = ""
    var coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D()
    
    @IBOutlet weak var startTimePicker: UIDatePicker!
    @IBOutlet weak var endTimePicker: UIDatePicker!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        startTimePicker.datePickerMode = .dateAndTime
        endTimePicker.datePickerMode = .dateAndTime
    }
    
    @IBAction func createJamEvent(_ sender: Any) {
        
        timeStart = DateFormatter.localizedString(from: startTimePicker.date, dateStyle: .short, timeStyle: .short)
        timeEnd = DateFormatter.localizedString(from: endTimePicker.date, dateStyle: .short, timeStyle: .short)
        location = locationTextField.text!
        title = titleTextField.text!
        
        let eventsDB = Database.database().reference().child("Events")
        let eventDictionary = ["hostUID": Auth.auth().currentUser?.uid,
                               "timeStart": timeStart,
                               "timeEnd": timeEnd,
                               "location": location,
                               "title": title,
                               "latitude": coordinates.latitude,
                               "longitude": coordinates.longitude] as [String : Any]
        
        eventsDB.childByAutoId().setValue(eventDictionary) {
            (error, reference) in
            
            if error != nil {
                print(error!)
            } else {
                print("Event saved successfully")
            }
            
        self.performSegue(withIdentifier: "formToMap", sender: self)
        
    }
    
        func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
}
