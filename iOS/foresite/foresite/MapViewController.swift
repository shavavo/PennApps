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
import iOSDropDown

class MapViewController: UIViewController {

    @IBOutlet var mapView: GMSMapView!


    var locationManager: CLLocationManager!
    var userLocation: CLLocation? = nil
    
    var recentlySubmitted:String? = ""
    
    let DEFAULT_ZOOM: Float = 14
    
    var reports: [Report] = []
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var dropdown: DropDown!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureMapView()
        configureLocationManager()

        configureDatabase()
        
        beginGlobalQuery()

        if(recentlySubmitted != "") {
            let w = UIScreen.main.bounds.width
            
            if(recentlySubmitted != "Other") {
                self.view.makeToast("Tap here to read about what you can do to protect yourself in a " + recentlySubmitted!.lowercased(), duration: 8.0, point: CGPoint(x: w/2, y: 80), title: "Report Submitted", image: nil) { didTap in
                    if didTap {
                        self.performSegue(withIdentifier: "tips", sender: self)
                    } else {
                        print("completion without tap")
                    }
                }
            } else {
                self.view.makeToast("Report Submitted", position: .top)
            }
        }
        

        
        dropdown.optionArray = ["Earthquake", "Fire", "Flood", "Tsunami"]
        dropdown.optionIds = [0,1,2,3]
        dropdown.isSearchEnable = false
        dropdown.selectedRowColor = .lightGray
        dropdown.rowHeight = 50
        dropdown.listHeight = 200
        dropdown.text = "Resources"
        dropdown.didSelect{(selectedText , index ,id) in
            self.recentlySubmitted = selectedText
            self.performSegue(withIdentifier: "tips", sender: "resources")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tips" {
            if let destVC = segue.destination as? TipsViewController {
                destVC.type = recentlySubmitted!
                
                if sender as! String=="resources" {
                    destVC.showBefore=true;
                }
            }
        }
        else if segue.identifier == "newReport" {
            if let destVC = segue.destination as? ReportViewController {
                destVC.userLocation = self.userLocation
                
                
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
    
    func configureDatabase() {
        ref = Database.database().reference()
    }
    

}
