//
//  GeoViewController.swift
//  SampleApp
//
//  Created by Josh on 6/17/19.
//  Copyright © 2019 AccuV. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class GeoViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var latitudeValue: UILabel!
    @IBOutlet weak var longitudeValue: UILabel!
    let manager:CLLocationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self;
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        latitudeValue.text = String(locations[0].coordinate.latitude)
        longitudeValue.text = String(locations[0].coordinate.longitude)
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        
        map.setRegion(region, animated: true);
        map.showsUserLocation = true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
