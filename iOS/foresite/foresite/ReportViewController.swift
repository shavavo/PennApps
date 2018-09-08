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
        
        
        var type = pickerData[picker.selectedRow(inComponent: 0)]
        if(type=="Other") {
            type = customType.text!
        }
        
        let location = place
        let comments = commentTextField.text
        let currentDateTime = Date()
        
        // TODO: Hookup to db
        
        performSegue(withIdentifier: "submitReturn", sender: self)
    }
    
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "submitReturn" {
            if let destVC = segue.destination as? MapViewController {
                print("PLES")
                destVC.recentlySubmitted = pickerData[picker.selectedRow(inComponent: 0)]
            }
        }
    }
    
    
    var place:GMSPlace? = nil;
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerData = ["Flood", "Fire", "Earthquake", "Tsunami", "Other"]
        picker.selectRow(2, inComponent: 0, animated: false)
        customType.isHidden = true
        
        getCurrentPlace()
    }
    
    func getCurrentPlace() {
        let placesClient = GMSPlacesClient()
        placesClient.currentPlace(callback: { (placeLikelihoods, error) -> Void in
            if error != nil {
                // Handle error in some way.
            }
            
            if let placeLikelihood = placeLikelihoods?.likelihoods.first {
                let place = placeLikelihood.place
                // Do what you want with the returned GMSPlace.
                self.place = place
                self.updateAddressLabel(place: place)
            }
        })
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
        updateAddressLabel(place: place)
        self.place = place
    }
    
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)
        locationPicker.selectedSegmentIndex = 0
        
    }
    
    func updateAddressLabel(place:GMSPlace) {
        if let addressText = place.formattedAddress {
            address.text = addressText
        } else {
            address.text = String(place.coordinate.latitude) + ", " + String(place.coordinate.longitude)
        }
    }
    
    
    
    
    
    
}
