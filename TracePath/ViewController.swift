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

class ViewController: UIViewController {

    var locManager: CLLocationManager!
    var theMapView: MKMapView!
    var theToolBarView: UIToolbar!
    var userLocations: [CLLocation] = []
    var theTableViewShowed: Bool = false
    var recordTableViewController: RecordTableViewController = RecordTableViewController(nibName: "RecordTableViewController", bundle: nil)
    var statusViewController: StatusViewController = StatusViewController(nibName: "StatusViewController", bundle: nil)
    var debugViewController: DebugViewController = DebugViewController(nibName: "DebugViewController", bundle: nil)
    var mapViewController: MapViewController = MapViewController(nibName: "MapViewController", bundle: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // map view
//        self.theMapView = MKMapView(frame: self.view.frame)
//        self.theMapView.delegate = self
//        self.view.addSubview(self.theMapView)
//
//        // button bar view
//        //
//        // 0.04w <width: 0.92w, height: 0.1w content > 0.04w
//        //      0.08w
//        //
//        self.theToolBarView = UIToolbar(frame: CGRectMake(self.view.frame.size.width * 0.04, self.view.frame.size.height - self.view.frame.size.width * 0.18, self.view.frame.size.width * 0.92, self.view.frame.size.width * 0.1))
//        // make it Transparent
//        self.theToolBarView.setBackgroundImage(UIImage(), forToolbarPosition: UIBarPosition.Any, barMetrics: UIBarMetrics.Default)
//        self.theToolBarView.setShadowImage(UIImage(), forToolbarPosition: UIBarPosition.Any)
////        self.theToolBarView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.9)
//        self.theToolBarView.clipsToBounds = true // hidden top border
//        self.view.addSubview(self.theToolBarView)
//
//        var flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
//
//        // user tracking button
//        var trackButton = MKUserTrackingBarButtonItem(mapView: self.theMapView)
//        var allButton = UIBarButtonItem(title: "All", style: UIBarButtonItemStyle.Plain, target: self, action: "all:")
//        // start button
//        var recordButton = UIBarButtonItem(title: "Start", style: UIBarButtonItemStyle.Plain, target: self, action: "start:")
//        // play button
//        var playButton = UIBarButtonItem(title: "Play", style: UIBarButtonItemStyle.Plain, target: self, action: "play:")
//        self.theToolBarView.setItems([trackButton, allButton, recordButton, playButton], animated: true)

        //
//        var longPressGesture = UILongPressGestureRecognizer(target: self, action: "handleLongPressGesture:")
//        longPressGesture.delegate = self
//        longPressGesture.minimumPressDuration = 0.5
//        self.theMapView.addGestureRecognizer(longPressGesture)

        // location
//        self.locManager = CLLocationManager()
//        if ((UIDevice.currentDevice().systemVersion as NSString).floatValue >= 8.0) {
//            self.locManager!.requestWhenInUseAuthorization()
//        } else {
//            self.locManager!.startUpdatingLocation()
//        }
//        self.locManager!.delegate = self

        // map view
        self.mapViewController.view.frame = self.view.frame
        self.addChildViewController(self.mapViewController)
        self.view.addSubview(self.mapViewController.view)

        // debug view
        self.debugViewController.view.frame = CGRect(x: 0, y: statusBarFrame.height, width: self.view.frame.size.width, height: self.view.frame.size.height - statusBarFrame.height)
        self.addChildViewController(self.debugViewController)
        self.view.addSubview(self.debugViewController.view)

        // status view controller
        self.statusViewController.view.frame = CGRect(x: 0, y:statusBarFrame.height, width: 200, height: 200)
        self.addChildViewController(self.statusViewController)
        self.view.addSubview(self.statusViewController.view)
    }

    func debug(message: String) {
        self.debugViewController.log(message)
    }

    func locationManager(_manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        self.debug("didChangeAuthorizationStatus: %d".format(status.toRaw()))
        if (status == CLAuthorizationStatus.AuthorizedWhenInUse) {
            self.theMapView.showsUserLocation = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
