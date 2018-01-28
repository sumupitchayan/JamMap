//
//  MapViewController.swift
//  Jammap
//
//  Created by Sumu Pitchayan on 1/27/18.
//  Copyright © 2018 Sumu Pitchayan. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        annotation.title = "The b01s"
        annotation.coordinate = coordinates
        map.addAnnotation(annotation)
        
        //ADD GESTURE RECOGNIZER:
        let uilpgr = UILongPressGestureRecognizer(target: self, action: #selector(self.longpress(gestureRecognizer:)))
        uilpgr.minimumPressDuration = 2
        map.addGestureRecognizer(uilpgr)
    }

    @objc func longpress(gestureRecognizer: UILongPressGestureRecognizer) {
        
        if gestureRecognizer.state == .ended {
            
                performSegue(withIdentifier: "jamFormSegue", sender: self)
            
        }
        
        
        
        let touchPoint = gestureRecognizer.location(in: map)
        
        let coordinate = map.convert(touchPoint, toCoordinateFrom: map)
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = coordinate
        
        annotation.title = "New place"
        
        annotation.subtitle = "Maybe I'll go here too..."
        
        map.addAnnotation(annotation)
        
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
