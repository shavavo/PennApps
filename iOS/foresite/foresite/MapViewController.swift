//
//  MapViewController.swift
//  foresite
//
//  Created by David Cheng on 9/8/18.
//  Copyright © 2018 2DGB. All rights reserved.
//

import UIKit
import CoreLocation

import GoogleMaps
import GooglePlaces

import FirebaseCore
import Firebase

import Toast_Swift

class MapViewController: UIViewController {

    @IBOutlet var mapView: GMSMapView!

    
    
    var locationManager: CLLocationManager!
    var userLocation: CLLocation? = nil
    
    var recentlySubmitted:String? = ""
    
    let DEFAULT_ZOOM: Float = 14
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureMapView()
        configureLocationManager()
        
       
        
        if(recentlySubmitted != "") {
            let w = UIScreen.main.bounds.width
            
            self.view.makeToast("Tap here to read about what you can do to protect yourself in a " + recentlySubmitted!.lowercased(), duration: 8.0, point: CGPoint(x: w/2, y: 110.0), title: "Report Submitted", image: nil) { didTap in
                if didTap {
                    print("completion from tap")
                } else {
                    print("completion without tap")
                }
            }
            
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureMapView() {
        
        mapView.delegate = self
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
        
        let defaultCameraPosition = GMSCameraPosition.camera(withLatitude: 39.952326, longitude: -75.191075, zoom: DEFAULT_ZOOM)
        
        mapView.animate(to: defaultCameraPosition)
        
        if (userLocation != nil) {
            let userLocationCameraPosition = GMSCameraPosition.camera(withLatitude: (userLocation?.coordinate.latitude)!, longitude: (userLocation?.coordinate.longitude)!, zoom: DEFAULT_ZOOM)
            mapView.animate(to: userLocationCameraPosition)
        }

        DispatchQueue.main.async {
            self.mapView.isMyLocationEnabled = true
        }
    }
}
