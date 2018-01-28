//
//  FormViewController.swift
//  Jammap
//
//  Created by Sumu Pitchayan on 1/27/18.
//  Copyright © 2018 Sumu Pitchayan. All rights reserved.
//

import UIKit

class FormViewController: UIViewController {
    
    var host = ""
    var timeStart = ""
    var timeEnd = ""
    var location: String = ""
    //var 
    
    @IBOutlet weak var startTimePicker: UIDatePicker!
    @IBOutlet weak var endTimePicker: UIDatePicker!
    @IBOutlet weak var locationTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        startTimePicker.datePickerMode = .dateAndTime
        endTimePicker.datePickerMode = .dateAndTime
    }
    

    /*
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        timeStart = startTimePicker.date
        timeEnd = endTimePicker.date
        
        print(timeStart)
        print(timeEnd)
    }
    */
    
    @IBAction func createJamEvent(_ sender: Any) {
        
        //let test = startTimePicker.calendar.
        
        timeStart = DateFormatter.localizedString(from: startTimePicker.date, dateStyle: .short, timeStyle: .short)
        timeEnd = DateFormatter.localizedString(from: endTimePicker.date, dateStyle: .short, timeStyle: .short)
        
        //print(timeStart)
        //print(DateFormatter.localizedString(from: timeStart, dateStyle: .short, timeStyle: .short))
        
        print("TEST:")
                print(timeStart)
                print(timeEnd)
        //print(test)
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
