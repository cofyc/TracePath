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

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {

    var locManager: CLLocationManager!
    var theMapView: MKMapView!
    var theToolBarView: UIToolbar!
    var userLocations: [CLLocation] = []
    var theTableView: UITableView!
    var debugView: UITextView!
    var items = ["We", "Heart", "Swift"]
    var theTableViewShowed = false

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
        var allButton = UIBarButtonItem(title: "All", style: UIBarButtonItemStyle.Plain, target: self, action: "all:")
        // start button
        var recordButton = UIBarButtonItem(title: "Start", style: UIBarButtonItemStyle.Plain, target: self, action: "start:")
        // play button
        var playButton = UIBarButtonItem(title: "Play", style: UIBarButtonItemStyle.Plain, target: self, action: "play:")

        self.theToolBarView.setItems([trackButton, allButton, recordButton, playButton], animated: true)

        //
        var longPressGesture = UILongPressGestureRecognizer(target: self, action: "handleLongPressGesture:")
        longPressGesture.delegate = self
        longPressGesture.minimumPressDuration = 0.5
        self.theMapView.addGestureRecognizer(longPressGesture)

        // location
        self.locManager = CLLocationManager()
        if ((UIDevice.currentDevice().systemVersion as NSString).floatValue >= 8.0) {
            self.locManager!.requestWhenInUseAuthorization()
        } else {
            self.locManager!.startUpdatingLocation()
        }
        self.locManager!.delegate = self

        // debug view
        let viewRect = CGRect(x: 10, y: 10, width: self.view.frame.size.width - 20, height: self.view.frame.size.height - 20)
        self.debugView = UITextView(frame: viewRect)
//        self.debugView.setBackgroundImage(UIImage(), forToolbarPosition: UIBarPosition.Any, barMetrics: UIBarMetrics.Default)
        self.debugView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.1)
        self.debugView.userInteractionEnabled = false
        self.view.addSubview(self.debugView)
        self.debug("system started")
    }

    func debug(log: String) {
        self.debugView.text = self.debugView.text.stringByAppendingString(log + "\n")
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
        self.center_to_location(userLocation)
        self.userLocations.append(userLocation)
    }

    func center_to_location(location: CLLocation) {
        var center = location.coordinate
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.theMapView.setRegion(region, animated: true)
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
            pinView!.draggable = true
            pinView!.pinColor = .Purple
        } else {
            pinView!.annotation = annotation
        }
        return pinView
    }

    // drag pin (TODO)
    func  mapView(mapView: MKMapView!, annotationView: MKAnnotationView!, didChangeDragState newState: MKAnnotationViewDragState, fromOldState oldState:MKAnnotationViewDragState) {
        println("annotationView/didChangeDragState");
    }

    func mapView(mapView: MKMapView!, didLongPressAtCoordinate coordinate: CLLocationCoordinate2D) {
        println("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
    }

    func all(sender: UIBarButtonItem) {
        // show table view
        var frame = CGRectMake(self.view.frame.size.width * 0.04, self.view.frame.size.width * 0.04, self.view.frame.size.width * 0.92, 0)
        var dropDownFrame = CGRectMake(self.view.frame.size.width * 0.04, self.view.frame.size.width * 0.04, self.view.frame.size.width * 0.92, self.view.frame.size.height * 0.85)
        if self.theTableView == nil {
            self.theTableView = UITableView()
            self.theTableView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.7)
            self.theTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
            self.theTableView.frame = frame;
            self.theTableView.dataSource = self;
            self.theTableView.delegate = self;
            self.view.addSubview(self.theTableView)
        }

        self.theTableView.reloadData()

        // drop animation
        if (!self.theTableViewShowed) {
            UIView.animateWithDuration(0.75, animations: {
                self.theTableView.frame = dropDownFrame
                }, completion: { (finished: Bool) in
                    println("table view drop down expaned")
            })
        } else {
            UIView.animateWithDuration(0.75, animations: {
                self.theTableView.frame = frame
                }, completion: { (finished: Bool) in
                    println("table view drop down collapsed")
                    //                self.theTableView.hidden = true
            })
        }
        self.theTableViewShowed = !self.theTableViewShowed
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
                        self.playLocation(CLLocation(latitude: element.latitude, longitude: element.longitude))
                        sleep(2)
                    }
                })
            }
        }
    }

    func playLocation(location: CLLocation) {
        let point = MKPointAnnotation()
        point.coordinate = location.coordinate
        self.theMapView.addAnnotation(point)
        self.center_to_location(location)
    }

    func handleLongPressGesture(sender: UIGestureRecognizer) {
        println("long pressed")
        if (sender.state == UIGestureRecognizerState.Ended) {
            return
//            self.theMapView.removeGestureRecognizer(sender)
        }

        // here we get the CGPoint for the touch and convert it to latitude and longitude coordinate to display on the map
        var point = sender.locationInView(self.theMapView)
        var coordinate = self.theMapView.convertPoint(point, toCoordinateFromView:self.theMapView)
        // create annotation
        var dropPin = TPMKAnnotation(coordinate: coordinate)
        self.theMapView.addAnnotation(dropPin)

        println("total %d annotations" % [self.theMapView.annotations.count])

        var startPoint = self.theMapView.userLocation.coordinate
        var endPoint = coordinate
        var coordinates = [startPoint, endPoint]
        var polyline = MKPolyline(coordinates: &coordinates, count: coordinates.count)
//        self.theMapView.removeOverlays(self.theMapView.overlays)
        self.theMapView.addOverlay(polyline)
    }

    // called to draw overlay
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        if overlay is MKPolyline {
            var polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.blueColor()
            polylineRenderer.lineWidth = 3
            return polylineRenderer
        }
        return nil
    }

    // S table view
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }

    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell:UITableViewCell = self.theTableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        cell.textLabel.text = self.items[indexPath.row]
        return cell
    }

    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        println("You selected cell #\(indexPath.row)!")
    }
    // E table view

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
