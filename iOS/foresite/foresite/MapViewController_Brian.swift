//
//  MapViewController_Brian.swift
//  foresite
//
//  Created by Brian Li on 9/8/18.
//  Copyright © 2018 2DGB. All rights reserved.
//

import Foundation
import CoreLocation
import GoogleMaps

extension MapViewController: CLLocationManagerDelegate {
    
    func configureLocationManager() {
        print("Called\n\n\n")
        // initialize locationManager
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        locationManager.requestAlwaysAuthorization()
        
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("Authorization status changed")
        if (status == .authorizedWhenInUse) {
            
        } else if (status == .authorizedAlways) {
        
        } else if (status == .denied) {
            
        } else if (status == .restricted) {
            
        } else if (status == .notDetermined) {
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // locations.last

    }
}

extension MapViewController: GMSMapViewDelegate {
    
}
