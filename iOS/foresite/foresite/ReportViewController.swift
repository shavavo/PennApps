//
//  ReportViewController.swift
//  foresite
//
//  Created by David Cheng on 9/8/18.
//  Copyright © 2018 2DGB. All rights reserved.
//

import Foundation
import UIKit
import GooglePlacePicker
import Firebase
import GeoFire


class ReportViewController: UIViewController, GMSPlacePickerViewControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var userLocation: CLLocation? = nil
    
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var customType: UITextField!
    @IBOutlet weak var locationPicker: UISegmentedControl!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var commentTextField: UITextField!
    
    @IBAction func locationTypeChanged(_ sender: Any) {
        if(locationPicker.selectedSegmentIndex==1) {
            let config = GMSPlacePickerConfig(viewport: nil)
            let placePicker = GMSPlacePickerViewController(config: config)
            
            placePicker.delegate = self
            present(placePicker, animated: true, completion: nil)
        } else {
            getCurrentPlace()
        }
    }
    
    @IBAction func submitReport(_ sender: Any) {
        
        let newReport = Report()
        
        newReport.latitude = place?.coordinate.latitude
        newReport.longitude = place?.coordinate.longitude
        
        let type = pickerData[picker.selectedRow(inComponent: 0)]
        switch type {
        case "Flood":
            newReport.disasterType = .flood
        case "Fire":
            newReport.disasterType = .fire
        case "Earthquake":
            newReport.disasterType = .earthquake
        case "Tsunami":
            newReport.disasterType = .tsunami
        case "Other":
            newReport.disasterType = .other
            newReport.otherDescription = customType.text!
        default:
            print("error: defaulted")
        }
        
        newReport.comment = commentTextField.text
        
        newReport.deviceID = UIDevice.current.identifierForVendor!.uuidString
        newReport.isInitialReport = true
        // uniqueID set later
        newReport.hasSeen = true
        
        uploadReport(report: newReport)
        
        performSegue(withIdentifier: "submitReturn", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "submitReturn" {
            if let destVC = segue.destination as? MapViewController {
                destVC.recentlySubmitted = pickerData[picker.selectedRow(inComponent: 0)]
            }
        }
    }
    
    
    var place:CLLocation? = nil
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerData = ["Earthquake", "Fire", "Flood", "Tsunami", "Other"]
        picker.selectRow(2, inComponent: 0, animated: false)
        customType.isHidden = true
        
        getCurrentPlace()
    }
    
    func getCurrentPlace() {

        
        self.place = userLocation
        self.updateAddressLabel()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
  
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
  
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(row==pickerData.count - 1) {
            customType.isHidden = false
        } else {
            customType.isHidden = true
        }

    }
    
    // Receive picked place
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)
        
        self.place = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        updateAddressLabel()
    }
    
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)
        locationPicker.selectedSegmentIndex = 0
        
    }
    
    func updateAddressLabel() {
        address.text = (place?.coordinate.latitude.description)! + ", " + (place?.coordinate.longitude.description)!
        
       
    }
    
    
    
}

// MARK: -Firebase data upload
extension ReportViewController {
    func uploadReport(report: Report) {
        
        let dbRef = Database.database().reference().child("reports")
        let reportRef = dbRef.childByAutoId()
        let reportAutoID = reportRef.key
        report.uniqueID = reportAutoID
        reportRef.updateChildValues(report.toDict())
 
        
        // GeoFire implementation
        /*
        let geofireRef = Database.database().reference().child("reports")
        
        let reportRef = geofireRef.childByAutoId()
        let reportAutoID = reportRef.key
        report.uniqueID = reportAutoID
        
        let geoFire = GeoFire(firebaseRef: geofireRef)
        
        geoFire.setLocation(CLLocation(latitude: report.latitude, longitude: report.longitude), forKey: reportAutoID)
        
        reportRef.updateChildValues(report.toDict())
         */
        
    }
}
