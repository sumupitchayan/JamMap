//
//  Event.swift
//  Jammap
//
//  Created by Sumu Pitchayan on 1/27/18.
//  Copyright © 2018 Sumu Pitchayan. All rights reserved.
//

import Foundation
import MapKit

class Event {
    
    var host: String = ""
    var timeStart = 0
    var timeEnd = 0
    var location = ""
    var coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
}
