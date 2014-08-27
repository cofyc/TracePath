//
//  TPMapAnnotation.swift
//  TracePath
//
//  Created by Cofyc on 8/27/14.
//
//

import Foundation
import MapKit

class TPMKAnnotation: NSObject, MKAnnotation {

    var title: String = ""
    var subtitle: String = ""
    var coordinate: CLLocationCoordinate2D

    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate;
    }

    func setCoordinate(newCoordinate: CLLocationCoordinate2D) {
        self.coordinate = newCoordinate
    }
}