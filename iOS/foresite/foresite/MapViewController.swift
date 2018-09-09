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
    
    var reports: [Report] = []
    var reportIDs: [String] = []
    var seenReportIDs = NSMutableSet()
    
    var ref: DatabaseReference!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureMapView()
        configureLocationManager()

        configureDatabase()

        if(recentlySubmitted != "") {
            let w = UIScreen.main.bounds.width
            
            if(recentlySubmitted != "Other") {
                self.view.makeToast("Tap here to read about what you can do to protect yourself in a " + recentlySubmitted!.lowercased(), duration: 8.0, point: CGPoint(x: w/2, y: 100), title: "Report Submitted", image: nil) { didTap in
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
        
        seenReportIDs.removeAllObjects()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tips" {
            if let destVC = segue.destination as? TipsViewController {
                destVC.type = recentlySubmitted!
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
    
    func addMarkers() {
        print(reports.count)
        
        for x in 0..<reports.count {
            if(!seenReportIDs.contains(reportIDs[x])) {

                var report = reports[x]

                print("ADDED MARKER")

                let position = CLLocationCoordinate2D(latitude: report.latitude, longitude: report.longitude)
                let marker = GMSMarker(position: position)

                let markerImage = UIImage(named: report.disasterType.rawValue)!
                let markerView = UIImageView(frame: CGRect(x:0, y:0, width:50, height:50))
                markerView.image = markerImage

                marker.iconView = markerView
                marker.tracksViewChanges = false
                marker.map = mapView
                marker.title = report.comment
         
               
                seenReportIDs.add(reportIDs[x])

            }

        }
    }
}
