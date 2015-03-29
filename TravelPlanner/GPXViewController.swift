//
//  GPXViewController.swift
//  TravelPlanner
//
//  Created by Claire on 3/7/15.
//  Copyright (c) 2015 XiaoJu. All rights reserved.
//

import UIKit
import MapKit

class GPXViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    
    var scenerySpots = [[String]]()
    
    var locationManager: CLLocationManager?
    
    var matchingItems: [MKMapItem] = [MKMapItem]()
    var routes: [MKRoute] = [MKRoute]()
    
    var routeIndex: Int?
    
    var movieName: String?
    
    
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.mapType = .Standard
            mapView.delegate = self
            mapView.showsUserLocation = true
        }
    }
    
    func mapView(mapView: MKMapView!,
        didFailToLocateUserWithError error: NSError!) {
            displayAlertWithTitle("Failed",
                message: "Could not get the user's location")
    }
    
    
    func mapView(mapView: MKMapView!,
        didUpdateUserLocation userLocation: MKUserLocation!) {
            
            let request = MKLocalSearchRequest()
            request.naturalLanguageQuery = "park";
            
            var delta = 5.0
            
            if let transportation = NSUserDefaults.standardUserDefaults().stringForKey(Constants.Transportation) {
                if(transportation == "walk") {
                    delta = 0.2
                }
            }
            
            let span = MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta)
            
            request.region = MKCoordinateRegion(
                center: userLocation.location.coordinate,
                span: span)
            
            let search = MKLocalSearch(request: request)
            
            search.startWithCompletionHandler{
                (response: MKLocalSearchResponse!, error: NSError!) in
                
                var count = 0
                self.routes.removeAll()
                self.matchingItems.removeAll()
                
                if response == nil {
                    return
                }
                
                for item in response.mapItems as [MKMapItem] {
                    
                    if self.routeIndex == nil || count == self.routeIndex {
                        self.matchingItems.append(item as MKMapItem)
                        var annotation = MKPointAnnotation()
                        annotation.coordinate = item.placemark.coordinate
                        annotation.title = item.name
                        self.mapView.addAnnotation(annotation)
                        var spot = [String]()
                        spot.append("Location:  " + item.name)
                        self.scenerySpots.append(spot)
                        self.getDirections(item)
                        
                    }
                    count++;
                }
                
            }
            
    }
    
    
    func locationManager(manager: CLLocationManager!,
        didUpdateToLocation newLocation: CLLocation!,
        fromLocation oldLocation: CLLocation!){
            
            println("Latitude = \(newLocation.coordinate.latitude)")
            println("Longitude = \(newLocation.coordinate.longitude)")
            
    }
    
    func locationManager(manager: CLLocationManager!,
        didFailWithError error: NSError!){
            println("Location manager failed with error = \(error)")
    }
    
    func locationManager(manager: CLLocationManager!,
        didChangeAuthorizationStatus status: CLAuthorizationStatus){
            
            print("The authorization status of location services is changed to: ")
            
            switch CLLocationManager.authorizationStatus(){
            case .Denied:
                println("Denied")
            case .NotDetermined:
                println("Not determined")
            case .Restricted:
                println("Restricted")
            default:
                showUserLocationOnMapView()
            }
            
    }
    
    func displayAlertWithTitle(title: String, message: String){
        let controller = UIAlertController(title: title,
            message: message,
            preferredStyle: .Alert)
        
        controller.addAction(UIAlertAction(title: "OK",
            style: .Default,
            handler: nil))
        
        presentViewController(controller, animated: true, completion: nil)
        
    }
    
    func showUserLocationOnMapView(){
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .Follow
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if CLLocationManager.locationServicesEnabled(){
            
            switch CLLocationManager.authorizationStatus(){
            case .Denied:
                displayAlertWithTitle("Not Determined",
                    message: "Location services are not allowed for this app")
            case .NotDetermined:
                locationManager = CLLocationManager()
                if let manager = locationManager {
                    manager.delegate = self
                    manager.requestWhenInUseAuthorization()
                }
            case .Restricted:
                displayAlertWithTitle("Restricted",
                    message: "Location services are not allowed for this app")
            default:
                showUserLocationOnMapView()
            }
            
            
        } else {
            println("Location services are not enabled")
        }
    }
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.showsUserLocation = true
        
    }
    
    func getDirections(item: MKMapItem) {
        
        let request = MKDirectionsRequest()
        request.setSource(MKMapItem.mapItemForCurrentLocation())
        request.setDestination(item)
        request.requestsAlternateRoutes = false
        
        let directions = MKDirections(request: request)
        
        directions.calculateDirectionsWithCompletionHandler({(response:
            MKDirectionsResponse!, error: NSError!) in
            
            if error != nil {
                println("Error getting directions")
            } else {
                self.showRoute(response)
            }
            
        })
    }
    
    var index = 0
    
    func showRoute(response: MKDirectionsResponse) {
        
        for route in response.routes as [MKRoute] {
            routes.append(route)
            mapView.addOverlay(route.polyline,
                level: MKOverlayLevel.AboveRoads)
            scenerySpots[index].append("Distance:  " + route.distance.description + "m")
            scenerySpots[index].append("Expected Time:  " + route.expectedTravelTime.description + "s")
        }
        index++
        let userLocation = mapView.userLocation
        let region = MKCoordinateRegionMakeWithDistance(
            userLocation.location.coordinate, 2000, 2000)
        
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(mapView: MKMapView!, rendererForOverlay
        overlay: MKOverlay!) -> MKOverlayRenderer! {
            let renderer = MKPolylineRenderer(overlay: overlay)
            
            renderer.strokeColor = UIColor.blueColor()
            renderer.lineWidth = 5.0
            return renderer
    }
    
   
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Show Spots" {
            if let stvc = segue.destinationViewController as? ScenerySpotTableViewController {
                stvc.setScenerySpots(scenerySpots)
            }
        }
    }
    
    
    
    private struct Constants {
        static let Transportation = "Transportation"
        
    }

}