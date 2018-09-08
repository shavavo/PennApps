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

class MapViewController: UIViewController {

    @IBOutlet var mapView: GMSMapView!
    
    var locationManager: CLLocationManager!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureMapView()
        configureLocationManager()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureMapView() {
        mapView.delegate = self
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
        
        DispatchQueue.main.async {
            self.mapView.isMyLocationEnabled = true
        }
    }
}
