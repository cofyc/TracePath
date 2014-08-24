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

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    var locManager: CLLocationManager!
    var theMapView: MKMapView!
    var theToolBarView: UIToolbar!
    var userLocations: [CLLocation] = []

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
        self.theToolBarView = UIToolbar(frame: CGRectMake(self.view.frame.size.width * 0.04, self.view.frame.size.height - self.view.frame.size.width * 0.18, self.view.frame.size.width * 0.92, self.view.frame.size.width * 0.1))
        // make it Transparent
        self.theToolBarView.setBackgroundImage(UIImage(), forToolbarPosition: UIBarPosition.Any, barMetrics: UIBarMetrics.Default)
        self.theToolBarView.setShadowImage(UIImage(), forToolbarPosition: UIBarPosition.Any)
//        self.theToolBarView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.9)
        self.theToolBarView.clipsToBounds = true // hidden top border
        self.view.addSubview(self.theToolBarView)

        var flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)

        // user tracking button
        var trackButton = MKUserTrackingBarButtonItem(mapView: self.theMapView)
        // start button
        var recordButton = UIBarButtonItem(title: "Start", style: UIBarButtonItemStyle.Plain, target: self, action: "start:")
        // play button
        var playButton = UIBarButtonItem(title: "Play", style: UIBarButtonItemStyle.Plain, target: self, action: "play:")

        self.theToolBarView.setItems([trackButton, recordButton, playButton], animated: true)

        // location
        self.locManager = CLLocationManager()
        if ((UIDevice.currentDevice().systemVersion as NSString).floatValue >= 8.0) {
            self.locManager!.requestWhenInUseAuthorization()
        } else {
            self.locManager!.startUpdatingLocation()
        }
        self.locManager!.delegate = self
    }

    func locationManager(_manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        println("didChangeAuthorizationStatus: %d" % [status.toRaw()])
        if (status == CLAuthorizationStatus.AuthorizedWhenInUse) {
            self.theMapView.showsUserLocation = true
        }
    }

    func mapView(mapView: MKMapView!, didUpdateUserLocation mkUserLocation: MKUserLocation) {
        if (mkUserLocation.location? == nil) {
            return
        }
        var userLocation = mkUserLocation.location!
        println("Current location: %.8f, %.8f" % [userLocation.coordinate.latitude, userLocation.coordinate.longitude])
        if let last_location = self.userLocations.last? {
            println("Last location: %.8f, %.8f" % [last_location.coordinate.latitude, last_location.coordinate.longitude])
            var distance = last_location.distanceFromLocation(userLocation)
            println(String(format:"moved distance %.8f", distance))
        }
        self.userLocations.append(userLocation)
    }

    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        println("mapView/viewForAnnotation")
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            return nil
        }
        let reuseId = "pin"

        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
            pinView!.pinColor = .Purple
        } else {
            pinView!.annotation = annotation
        }
        return pinView
    }

    func start(sender: UIBarButtonItem!) {
        println(String(format: "pressed %@ button", sender!.title!))
    }

    func play(sender: UIBarButtonItem!) {
        println(String(format: "pressed %@ button", sender!.title!))
        let bundle = NSBundle.mainBundle()
        if let path = bundle.pathForResource("location", ofType: "gpx") {
            if let content = String.stringWithContentsOfFile(path, encoding: NSUTF8StringEncoding, error: nil) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                    var root = GPXParser.parseGPXWithString(content)
                    for (index, element) in enumerate(root.waypoints!) {
                        println("(Item %d) latitude: %.8f longitude: %.8f" % [index, element.latitude, element.longitude])
                        self.play_location(element.latitude, longitude: element.longitude)
                        sleep(2)
                    }
                })
            }
        }
    }

    func play_location(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        self.theMapView.showsUserLocation = false
//        CLLocationCoordinate2D  ctrpoint;
//        ctrpoint.latitude = 53.58448;
//        ctrpoint.longitude =-8.93772;
//        AddressAnnotation *addAnnotation = [[AddressAnnotation alloc] initWithCoordinate:ctrpoint];
//        [mapview addAnnotation:addAnnotation];
//        [addAnnotation release];

        let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        let point = MKPointAnnotation()
        point.coordinate = center
//        let location = CLLocation()
//        location.coordinate = center
//        point.location = location
        self.theMapView.addAnnotation(point)
        self.theMapView.setRegion(region, animated: true)
        self.theMapView.showsUserLocation = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
