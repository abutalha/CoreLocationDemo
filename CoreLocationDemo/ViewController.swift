//
//  ViewController.swift
//  CoreLocationDemo
//
//  Created by AbuTalha on 15/12/2021.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: Handle for Location Manager
    var locationManager = CLLocationManager()
    var canMove: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Configure Location Settings
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.startUpdatingLocation()
        
        //MARK: Use this if you want to handle any events related to MapView
        mapView.delegate = self
    }
    

    //MARK: MapView Delegate function to get location updates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print (locations.last)
        
        //MARK: Add a sample Marker Pin to Map
        addMarkerPin(for: locations.last?.coordinate)
    }
    
    func addMarkerPin(for location: CLLocationCoordinate2D?) {

        //MARK: Set some random location if its nil - just for demo
        var coordinate = location
        if (coordinate == nil) {
            coordinate = CLLocationCoordinate2D(latitude: +37.33756603, longitude: -122.04120235)
        }
        
        //MARK: Add a map pin
        let mapPin = MKPointAnnotation()
        mapPin.coordinate = coordinate!
        mapPin.title = "Walking"
        mapView.addAnnotation(mapPin)
        
        //MARK: Zoom to the selected pin
        if (canMove) {
            let region = MKCoordinateRegion(center: coordinate!, span: MKCoordinateSpan(latitudeDelta: 0, longitudeDelta: 0))
            mapView.setRegion(region, animated: true)
        }
    }
    
    @IBAction func stopMoving(_ sender: UIButton) {
        canMove = !canMove
        
    }
}

