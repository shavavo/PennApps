//
//  MapViewController_Brian.swift
//  foresite
//
//  Created by Brian Li on 9/8/18.
//  Copyright © 2018 2DGB. All rights reserved.
//

import UIKit
import CoreLocation

import GoogleMaps
import GooglePlaces

import FirebaseCore
import Firebase

import GeoFire

extension MapViewController: CLLocationManagerDelegate {
    
    func configureLocationManager() {
        print("Called\n\n\n")
        // initialize locationManager
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        locationManager.requestAlwaysAuthorization()
        
        locationManager.startUpdatingLocation()
        
        /*
        DispatchQueue.global(qos: .background).async {
            sleep(4)
            print("Active after 4 sec, and doesn't block main")
            self.generateData()
            DispatchQueue.main.async{
                //do stuff in the main thread here
            }
        }
        */
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
        userLocation = locations.last
    }
}

extension MapViewController: GMSMapViewDelegate {
    
}

// MARK: -Generate Data
extension MapViewController {
    
    func generateData() {
        let geofireRef = Database.database().reference().child("reports")
        
        let reportRef = geofireRef.childByAutoId()
        let reportAutoID = reportRef.key
        
        let geoFire = GeoFire(firebaseRef: geofireRef)
        
        geoFire.setLocation(userLocation!, forKey: reportAutoID)
        let rep = Report(latitude: (userLocation?.coordinate.latitude)!, longitude: (userLocation?.coordinate.longitude)!, time: Date(), disasterType: .fire, comment: "mild house fire")
        reportRef.updateChildValues(rep.toDict())
        //let geofireRef = FIRDatabase.database().reference()
        //let geoFire = GeoFire(firebaseRef: geofireRef)
    }
}
