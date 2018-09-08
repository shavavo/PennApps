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


class ReportViewController: UIViewController, GMSPlacePickerViewControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var customType: UITextField!
    @IBOutlet weak var locationPicker: UISegmentedControl!
    @IBOutlet weak var address: UILabel!
    
    @IBAction func locationTypeChanged(_ sender: Any) {
        if(locationPicker.selectedSegmentIndex==1) {
            let config = GMSPlacePickerConfig(viewport: nil)
            let placePicker = GMSPlacePickerViewController(config: config)
            
            placePicker.delegate = self
            present(placePicker, animated: true, completion: nil)
        }
    }
    
    //TODO: replace with user location
    var place:GMSPlace? = nil;
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerData = ["Flood", "Fire", "Earthquake", "Tsunami", "Other"]
        picker.selectRow(2, inComponent: 0, animated: false)
        customType.isHidden = true
        
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
        if let addressText = place.formattedAddress {
            address.text = addressText
        } else {
            address.text = String(place.coordinate.latitude) + ", " + String(place.coordinate.longitude)
        }
        
        
        self.place = place
    }
    
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)
        locationPicker.selectedSegmentIndex = 0
        
    }
    
    
    
    
    
    
}
