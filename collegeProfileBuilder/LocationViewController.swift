//
//  CoreLocationViewController.swift
//  collegeProfileBuilder
//
//  Created by cmacgregor on 5/10/17.
//  Copyright © 2017 cmacgregor. All rights reserved.
//

import UIKit
import MapKit
class CoreLocationViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var college = College()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        findLocation(location: college.name)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func searchButtonPressed(_ searchBar: UISearchBar){
        dismiss(animated: true, completion: nil)
        findLocation(location: searchBar.text!)
    }
    
    func findLocation(location: String) {
        let locationSearchRequest = MKLocalSearchRequest()
        locationSearchRequest.naturalLanguageQuery = location
        let locationSearch = MKLocalSearch(request: localSearchRequest)
        localSearch.start { (MKLocalSearchResponse, error) in
            if localSearchResponse == nil {
                let alertController = UIAlertController(title: nil, message: "location Not Found", PreferredStyle: .alert)
                alertController.addAction(UIAlertController(title: "Dismiss", style: .default , handler: nil))
                self.present(alertController, animated: true, completion: nil)
                return
            }
            let locations = localSearchResponse!.mapItems
            if locations.count > 1 {
                let alert = UIAlertController(title: "Select a location", message: nil, preferredStyle: .actionSheet)
                for location in locations {
                    let name = "\(location.placemark.name!), \(location.placemark.administrativeArea!)"
                    let locationAction = UIAlertAction(title: name, style: .default , handler: { (action) in self.displayMap(placemark: location.placemark)
                        
                    })
                    alert.addAction(locationAction)
                }
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel , handler: nil)
                alert.addAction(cancelAction)
                self.present(alert, animated: true, completion: nil)
            }
            else {
                self.displayMap(placemark: locations.first!.placemark)
            }
        }
    }

    func DisplayMap(placemark: MKPlacemark){
        self.navigationItem.title = placemark.name
        let center = placemark.location!.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)
        let region = MKCoordinateRegion(center: center, span: span)
        let pin = MKPointAnnotation()
        pin.coordinate = center
        pin.title = placemark.name
        mapView.addAnnotation(pin)
        mapView.setRegion(region, animated: true)
    }
    
    @IBAction func activateSearchBar(_ sender: UIBarButtonItem) {
    let searchController = UISearchController(searchResultsController: nil)
    searchController.hidesNavigationBarDuringPresentation = false
    searchController.searchBar.delegate = self
    present(searchController, animated:  true, completion: nil)
    }
}







