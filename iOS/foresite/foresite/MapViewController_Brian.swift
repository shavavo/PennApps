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
//        print("Called\n\n\n")
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
//        print("Authorization status changed")
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
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        
        // GeoFire implementation
        //queryCircle(withCenter: CLLocation(latitude: position.target.latitude, longitude: position.target.longitude), radius: 15)
    }
}

// MARK: -Generate Data
extension MapViewController {
    /*
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
    */
}

// MARK: -GeoQuery
extension MapViewController {
    func queryCircle(withCenter location: CLLocation, radius: Double) {
//        print("\nthe lcoation is ")
//        print(location)
        // clear previous values stored in reports
        reports = []
        
        let geofireReportsRef = Database.database().reference().child("reports")
        let geoFire = GeoFire(firebaseRef: geofireReportsRef)
        
        let center = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        // Query locations at center with a radius of km
        let circleQuery = geoFire.query(at: center, withRadius: radius)

        // TODO: impose limitations on query size
        
        var queryHandle = circleQuery.observe(.keyEntered, with: { (key: String!, location: CLLocation!) in
            self.ref.child("reports").child(key).observe(.value, with: { (snapshot) in
                self.reports.append(Report(fromSnapshot: snapshot))
//                print("\ndata extracted")
            }) { (error) in
//                print(error.localizedDescription)
            }
            /*
            ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                let username = value?["username"] as? String ?? ""
                let user = User(username: username)
                
                // ...
            }) { (error) in
                print(error.localizedDescription)
            }
            */
            
        })
        
        circleQuery.observeReady {
            // All initial data has been loaded and events have been fired!
         
        }
        
        
        
        
        /*
        // Query location by region
        let span = MKCoordinateSpanMake(0.001, 0.001)
        let region = MKCoordinateRegionMake(center.coordinate, span)
        var regionQuery = geoFire.queryWithRegion(region)
        
        var queryHandle = query.observeEventType(.KeyEntered, withBlock: { (key: String!, location: CLLocation!) in
            print("Key '\(key)' entered the search area and is at location '\(location)'")
        })
        */
    }
    
    func beginGlobalQuery() {
        let dbRef = Database.database().reference()
        let reportsRef = dbRef.child("reports")
        reportsRef.observe(.childAdded, with: { (snapshot) in
            let report = Report(fromSnapshot: snapshot)
            self.reports.append(report)
            
   
    
            let position = CLLocationCoordinate2D(latitude: report.latitude, longitude: report.longitude)
            let marker = GMSMarker(position: position)
            
            let markerImage = UIImage(named: report.disasterType.rawValue)!
            let markerView = UIImageView(frame: CGRect(x:0, y:0, width:50, height:50))
            markerView.image = markerImage
            
            marker.iconView = markerView
            marker.tracksViewChanges = false
            marker.map = self.mapView
            marker.title = report.comment
            
            
        })
    }
}
