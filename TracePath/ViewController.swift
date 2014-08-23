//
//  ViewController.swift
//  TracePath
//
//  Created by Cofyc on 8/23/14.
//
//

import UIKit
import MapKit
import CoreLocation

func %(format:String, args:[CVarArgType]) -> String {
    return NSString(format:format, arguments:getVaList(args))
}


class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    var locManager: CLLocationManager!
    var theMapView: MKMapView!
    var theBtnView: UIToolbar!

    override func viewDidLoad() {
        super.viewDidLoad()

        // map view
        self.theMapView = MKMapView(frame: self.view.frame)
        self.theMapView.delegate = self
        self.view.addSubview(self.theMapView)

        // button bar view
        //
        // 0.04w <width: 0.92w, height: 0.1w content > 0.04w
        //      0.08w
        //
        self.theBtnView = UIToolbar(frame: CGRectMake(self.view.frame.size.width * 0.04, self.view.frame.size.height - self.view.frame.size.width * 0.18, self.view.frame.size.width * 0.92, self.view.frame.size.width * 0.1))
        self.theBtnView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.9)
        self.view.addSubview(self.theBtnView)

        // user tracking button
        var trackButton = MKUserTrackingBarButtonItem(mapView: self.theMapView)
        self.theBtnView.setItems([trackButton], animated: true)

        // location
        self.locManager = CLLocationManager()
        if ((UIDevice.currentDevice().systemVersion as NSString).floatValue >= 8.0) {
            self.locManager!.requestWhenInUseAuthorization()
        } else {
            self.locManager!.startUpdatingLocation()
        }
        self.locManager!.delegate = self
    }

    func locationManager(_manager: CLLocationManager!,didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        println("didChangeAuthorizationStatus")
        self.theMapView.showsUserLocation = true
    }

    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
        println("Current location: %.8f, %.8f" % [userLocation.coordinate.latitude, userLocation.coordinate.longitude])
//        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
//        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
//        self.theMapView.setRegion(region, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
