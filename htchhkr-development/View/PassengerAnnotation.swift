//
//  PassengerAnnotation.swift
//  htchhkr-development
//
//  Created by mitsuyoshi matsuo on 2019/03/28.
//  Copyright © 2019 mitsuyoshi matsuo. All rights reserved.
//

import Foundation
import MapKit

class PassengerAnnotation: NSObject, MKAnnotation {
    dynamic var coordinate: CLLocationCoordinate2D
    var key: String
    
    init(coordinate: CLLocationCoordinate2D, key: String) {
        self.coordinate = coordinate
        self.key = key
        super.init()
    }
}
