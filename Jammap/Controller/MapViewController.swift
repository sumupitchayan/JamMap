//
//  MapViewController.swift
//  Jammap
//
//  Created by Sumu Pitchayan on 1/27/18.
//  Copyright © 2018 Sumu Pitchayan. All rights reserved.
//

import UIKit
import Firebase
import MapKit
//import PopupDialog
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var userCreatedJamCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()

    var selectedEventHost = ""
    
    var selectedEventTitle = ""
    var selectedEventLocation = ""
    var selectedEventStart = ""
    var selectedEventEnd = ""
    var selectedEventNotes = ""
    
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        map.delegate = self
        
        map.mapType = .satellite
        
        updateMapWithEvents()
        
        // Do any additional setup after loading the view.
        let latitude: CLLocationDegrees = 41.826772
        let longitude: CLLocationDegrees = -71.402548
        let latDelta: CLLocationDegrees = 0.005
        let lonDelta: CLLocationDegrees = 0.005
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let region: MKCoordinateRegion = MKCoordinateRegion(center: coordinates, span: span)
        
        map.setRegion(region, animated: true)
        
        //ANNOTATIONS:
        let annotation = MKPointAnnotation()
        annotation.title = "Hack@Brown!"
        annotation.coordinate = coordinates
        
        map.addAnnotation(annotation)
        
        //ADD GESTURE RECOGNIZER:
        let uilpgr = UILongPressGestureRecognizer(target: self, action: #selector(self.longpress(gestureRecognizer:)))
        uilpgr.minimumPressDuration = 2
        map.addGestureRecognizer(uilpgr)
    }

    @objc func longpress(gestureRecognizer: UILongPressGestureRecognizer) {
    
        let touchPoint = gestureRecognizer.location(in: map)
        
        let coordinate = map.convert(touchPoint, toCoordinateFrom: map)
        
        userCreatedJamCoordinate = coordinate
        
        if gestureRecognizer.state == .ended {
            
            performSegue(withIdentifier: "jamFormSegue", sender: self)
            
        }
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "New place"
        annotation.subtitle = "Maybe I'll go here too..."
        map.addAnnotation(annotation)
        
    }
    
    func updateMapWithEvents() {
        
        let eventsDB = Database.database().reference().child("Events")
        
        eventsDB.observeSingleEvent(of: .value, with: {snapshot in
            print(snapshot.childrenCount)
            for rest in snapshot.children.allObjects as! [DataSnapshot] {
                //print(rest.value)
                
                let eventDictionary = rest.value as? NSDictionary

                let hostUID = eventDictionary?["hostUID"] as? String ?? ""
                
                let latitude = eventDictionary?["latitude"] as! Double
                let longitude = eventDictionary?["longitude"] as! Double
                let title = eventDictionary?["title"] as? String ?? ""
                
                print(latitude)
                print(longitude)
                
                self.addEvent(lat: latitude, lon: longitude, title: title)
                
            }
        })
    
    }
    
    func addEvent(lat: Double, lon: Double, title: String) {
        
        let coord = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        
        let annotation = MKPointAnnotation()
        
        annotation.title = title
        
        annotation.coordinate = coord
        
        map.addAnnotation(annotation)
    }

    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "matchSegue" {
            let controller = segue.destinationViewController as! ResultViewController
            controller.match = self.match
        } else if segue.identifier == "historySegue" {
            let controller = segue.destinationViewController as! HistoryViewController
            controller.history = self.history
        }
    }
    */
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "jamFormSegue" {
            
            let formController = segue.destination as! FormViewController
            formController.coordinates = userCreatedJamCoordinate
            
        } else if segue.identifier == "toEvent" {
            
            let eventController = segue.destination as! EventViewController
            
            eventController.jamName = selectedEventTitle
            eventController.timeStart = selectedEventStart
            eventController.timeEnd = selectedEventEnd
            eventController.location = selectedEventLocation
            
        }
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        let eventCoord: CLLocationCoordinate2D = (view.annotation?.coordinate)!
        
        let eventLatitude: Double = eventCoord.latitude
        let eventLongitude: Double = eventCoord.longitude
        
        var checkLatitude: Double = 0
        var checkLongitude: Double = 0
        
        let eventsDB = Database.database().reference().child("Events")
    
        eventsDB.observeSingleEvent(of: .value, with: {snapshot in
            print(snapshot.childrenCount)
            
            for rest in snapshot.children.allObjects as! [DataSnapshot] {
                let eventDictionary = rest.value as? NSDictionary
                
                checkLatitude = eventDictionary?["latitude"] as! Double
                checkLongitude = eventDictionary?["longitude"] as! Double
                
                if (eventLatitude == checkLatitude && eventLongitude == checkLongitude) {
                
                    print ("found")
                    
                    self.selectedEventHost = eventDictionary?["hostUID"] as? String ?? ""
                    self.selectedEventTitle = eventDictionary?["title"] as! String
                    self.selectedEventLocation = eventDictionary!["location"] as! String
                    self.selectedEventStart = eventDictionary?["timeStart"] as! String
                    self.selectedEventEnd = eventDictionary?["timeEnd"] as! String
                    
                    self.performSegue(withIdentifier: "toEvent", sender: self)
                }
                

                
            }
        })
        
    }
    
    
    @IBAction func profileButtonPressed(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "toMyProfile", sender: self)
        
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
