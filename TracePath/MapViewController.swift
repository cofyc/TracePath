//
//  MapViewController.swift
//  TracePath
//
//  Created by Cofyc on 9/8/14.
//
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UIGestureRecognizerDelegate {

    @IBOutlet var toolbar: UIToolbar!

    override func viewDidLoad() {
        super.viewDidLoad()

        // hide top border
        self.toolbar.clipsToBounds = true

        // change height
//        let frame:CGRect = self.toolbar.frame // height is locked in IB
//        self.toolbar.frame = CGRect(origin: frame.origin, size: CGSize(width: frame.size.width, height: 30))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func mapView(mapView: MKMapView!, didUpdateUserLocation mkUserLocation: MKUserLocation) {
//        if (mkUserLocation.location? == nil) {
//            return
//        }
//        var userLocation = mkUserLocation.location!
////        self.statusViewController.update(userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
//        if let last_location = self.userLocations.last? {
//            var distance = last_location.distanceFromLocation(userLocation)
//        }
//        self.center_to_location(userLocation)
//        self.userLocations.append(userLocation)
    }

//    func center_to_location(location: CLLocation) {
//        var center = location.coordinate
//        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
//        self.theMapView.setRegion(region, animated: true)
//    }

//    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
//        if annotation is MKUserLocation {
//            //return nil so map view draws "blue dot" for standard user location
//            return nil
//        }
//        let reuseId = "pin"
//        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
//        if pinView == nil {
//            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
//            pinView!.canShowCallout = true
//            pinView!.animatesDrop = true
//            pinView!.draggable = true
//            pinView!.pinColor = .Purple
//        } else {
//            pinView!.annotation = annotation
//        }
//        return pinView
//    }
//
//    // drag pin (TODO)
//    func  mapView(mapView: MKMapView!, annotationView: MKAnnotationView!, didChangeDragState newState: MKAnnotationViewDragState, fromOldState oldState:MKAnnotationViewDragState) {
//        self.debug("annotationView/didChangeDragState");
//    }
//
//    func mapView(mapView: MKMapView!, didLongPressAtCoordinate coordinate: CLLocationCoordinate2D) {
//        self.debug("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
//    }

    func bookmarks(sender: UIBarButtonItem) {
//        var fullFrame = CGRectMake(0, statusBarFrame.height, screenWidth, 400);
//        var hiddenFrame = CGRectMake(0, statusBarFrame.height, screenWidth, 0);
//        // toggle view
//        if (!self.theTableViewShowed) {
//            self.recordTableViewController.view.frame = hiddenFrame
//            self.addChildViewController(recordTableViewController)
//            self.view.addSubview(recordTableViewController.view)
//            UIView.animateWithDuration(0.75, animations: {
//                self.recordTableViewController.view.frame = fullFrame
//                }, completion: { (finished: Bool) in
//                    self.debug("table view drop down expaned")
//            })
//        } else {
//            UIView.animateWithDuration(0.75, animations: {
//                self.recordTableViewController.view.frame = hiddenFrame
//                }, completion: { (finished: Bool) in
//                    self.debug("table view drop down collapsed")
//                    self.recordTableViewController.removeFromParentViewController()
//                    self.recordTableViewController.view.removeFromSuperview()
//            })
//        }
//        self.theTableViewShowed = !self.theTableViewShowed
    }

    @IBAction func record(sender: UIBarButtonItem!) {
        println("record")
//        self.debug(String(format: "pressed %@ button", sender!.title!))
//        let bundle = NSBundle.mainBundle()
//        if let path = bundle.pathForResource("location", ofType: "gpx") {
//            if let content = String.stringWithContentsOfFile(path, encoding: NSUTF8StringEncoding, error: nil) {
//                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
//                    var root = GPXParser.parseGPXWithString(content)
//                    for (index, element) in enumerate(root.waypoints!) {
//                        //                        self.debug("latitude: %.8f longitude: %.8f".format(element.latitude, element.longitude))
//                        self.playLocation(CLLocation(latitude: element.latitude, longitude: element.longitude))
//                        sleep(2)
//                    }
//                })
//            }
//        }
    }

//    func playLocation(location: CLLocation) {
//        let point = MKPointAnnotation()
//        point.coordinate = location.coordinate
//        self.theMapView.addAnnotation(point)
//        self.center_to_location(location)
//    }

//    func handleLongPressGesture(sender: UIGestureRecognizer) {
//        self.debug("long pressed")
//        if (sender.state == UIGestureRecognizerState.Ended) {
//            return
//            //            self.theMapView.removeGestureRecognizer(sender)
//        }
//
//        // here we get the CGPoint for the touch and convert it to latitude and longitude coordinate to display on the map
//        var point = sender.locationInView(self.theMapView)
//        var coordinate = self.theMapView.convertPoint(point, toCoordinateFromView:self.theMapView)
//        // create annotation
//        var dropPin = TPMKAnnotation(coordinate: coordinate)
//        self.theMapView.addAnnotation(dropPin)
//
//        self.debug("total %d annotations".format(self.theMapView.annotations.count))
//
//        var startPoint = self.theMapView.userLocation.coordinate
//        var endPoint = coordinate
//        var coordinates = [startPoint, endPoint]
//        var polyline = MKPolyline(coordinates: &coordinates, count: coordinates.count)
//        //        self.theMapView.removeOverlays(self.theMapView.overlays)
//        self.theMapView.addOverlay(polyline)
//    }
//
//    // called to draw overlay
//    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
//        if overlay is MKPolyline {
//            var polylineRenderer = MKPolylineRenderer(overlay: overlay)
//            polylineRenderer.strokeColor = UIColor.blueColor()
//            polylineRenderer.lineWidth = 3
//            return polylineRenderer
//        }
//        return nil
//    }

}
