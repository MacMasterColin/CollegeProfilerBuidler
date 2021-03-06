//
//  MapViewController.swift
//  collegeProfileBuilder
//
//  Created by cmacgregor on 3/10/17.
//  Copyright © 2017 cmacgregor. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var MapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for location in locations {
            if location.horizontalAccuracy < 1000 && location.verticalAccuracy < 1000 {
            }
            let center = location.coordinate
            let span = MKCoordinateSpanMake(0.01, 0.01)
            let region = MKCoordinateRegionMake(center, span)
            self.MapView.setRegion(region, animated: true)
            locationManager.stopUpdatingLocation()
        }
    }
}
