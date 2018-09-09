//
//  Report.swift
//  foresite
//
//  Created by Brian Li on 9/8/18.
//  Copyright © 2018 2DGB. All rights reserved.
//

import Foundation
import CoreLocation
import Firebase
import GeoFire


class Report {
    
    enum DisasterTypes: String {
        case flood = "flood"
        case fire = "fire"
        case tsunami = "tsunami"
        case earthquake = "earthquake"
        case other = "other"
    }
    
    var latitude: CLLocationDegrees!
    var longitude: CLLocationDegrees!
    var time: String!
    var disasterType: DisasterTypes!
    var comment: String!
    var otherDescription: String!
    
    var deviceID: String!
    var isInitialReport: Bool!
    var uniqueID: String!
    var hasSeen: Bool!
    
    init() {
        latitude = 0
        longitude = 0
        time = Date().toISO8601()
        disasterType = .other
        comment = ""
        otherDescription = ""
        
        deviceID = ""
        isInitialReport = true
        uniqueID = ""
        hasSeen = true
    }
    
    convenience init(latitude: CLLocationDegrees, longitude: CLLocationDegrees, time: Date, disasterType: DisasterTypes, comment: String, deviceID: String, isInitialReport: Bool, uniqueID: String, hasSeen: Bool) {
        self.init()
        
        self.latitude = latitude
        self.longitude = longitude
        self.time = time.toISO8601()
        self.disasterType = disasterType
        self.comment = comment
    }
    
    convenience init(fromDictionary dict: [String: Any]) {
        // create a default Report
        self.init()
        
        if let latitude = dict["latitude"] as? CLLocationDegrees {
            self.latitude = latitude
        }
        
        if let longitude = dict["longitude"] as? CLLocationDegrees {
            self.longitude = longitude
        }
        
        if let time = dict["time"] as? String {
            self.time = time
        }
        
        if let disasterType = dict["disasterType"] as? String {
            switch disasterType {
            case "flood":
                self.disasterType = .flood
            case "fire":
                self.disasterType = .fire
            case "tsunami":
                self.disasterType = .tsunami
            case "earthquake":
                self.disasterType = .earthquake
            case "other":
                self.disasterType = .other
                if let otherDescription = dict["otherDescription"] as? String {
                    self.otherDescription = otherDescription
                    print("the other description was fond")
                    print(self.otherDescription)
                    print("done")
                }
            default:
                print("error: defaulted")
            }
        }
        
        if let comment = dict["comment"] as? String {
            self.comment = comment
        }
        
        if let deviceID = dict["deviceID"] as? String {
            self.deviceID = deviceID
        }
        
        if let isInitialReport = dict["isInitialReport"] as? Bool {
            self.isInitialReport = isInitialReport
        }
        
        if let uniqueID = dict["uniqueID"] as? String {
            self.uniqueID = uniqueID
        }
        
        if let hasSeen = dict["hasSeen"] as? Bool {
            self.hasSeen = hasSeen
        }

    }
    
    convenience init(fromSnapshot snapshot: DataSnapshot) {
        // create a default Report
        self.init()
        
        if let latitude = snapshot.childSnapshot(forPath: "latitude").value as? CLLocationDegrees {
            self.latitude = latitude
        }
        
        if let longitude = snapshot.childSnapshot(forPath: "longitude").value as? CLLocationDegrees {
            self.longitude = longitude
        }
        
        if let time = snapshot.childSnapshot(forPath: "time").value as? String {
            self.time = time
        }
        
        if let disasterType = snapshot.childSnapshot(forPath: "disasterType").value as? String {
            switch disasterType {
            case "flood":
                self.disasterType = .flood
            case "fire":
                self.disasterType = .fire
            case "tsunami":
                self.disasterType = .tsunami
            case "earthquake":
                self.disasterType = .earthquake
            case "other":
                self.disasterType = .other
                if let otherDescription = snapshot.childSnapshot(forPath: "otherDescription").value as? String {
                    self.otherDescription = otherDescription
                    print("the other description is ")
                    print(self.otherDescription)
                    print("done")
                }
            default:
                print("error: defaulted")
            }
        }
        
        if let comment = snapshot.childSnapshot(forPath: "comment").value as? String {
            self.comment = comment
        }
        
        if let deviceID = snapshot.childSnapshot(forPath: "deviceID").value as? String {
            self.deviceID = deviceID
        }
        
        if let isInitialReport = snapshot.childSnapshot(forPath: "isInitialReport").value as? Bool {
            self.isInitialReport = isInitialReport
        }
        
        if let uniqueID = snapshot.childSnapshot(forPath: "uniqueID").value as? String {
            self.uniqueID = uniqueID
        }
        
        if let hasSeen = snapshot.childSnapshot(forPath: "hasSeen").value as? Bool {
            self.hasSeen = hasSeen
        }
    }
    
    func toDict() -> [String: Any] {
        return [
            "latitude" : latitude!,
            "longitude" : longitude!,
            "time" : time!,
            "disasterType" : disasterType.rawValue,
            "comment" : comment!,
            "otherDescription" : otherDescription!,
            "deviceID": deviceID!,
            "isInitialReport": isInitialReport!,
            "uniqueID": uniqueID!,
            "hasSeen": hasSeen!
        ]
    }
}

extension Report {
    func upload() {
        print(self)
        print("\nwill attempt to upload\n")
        
        let dbRef = Database.database().reference().child("reports")
        let reportRef = dbRef.childByAutoId()
        let reportAutoID = reportRef.key
        self.uniqueID = reportAutoID
        reportRef.updateChildValues(self.toDict())
 
        print("hi")
        // GeoCode Implementation
        /*
        let geofireRef = Database.database().reference().child("reports")

        let reportRef = geofireRef.childByAutoId()
        let reportAutoID = reportRef.key
        self.uniqueID = reportAutoID
        
        let geoFire = GeoFire(firebaseRef: geofireRef)
        
        geoFire.setLocation(CLLocation(latitude: self.latitude, longitude: self.longitude), forKey: reportAutoID)
        print("the report auto id is ... \(reportAutoID)")
        reportRef.updateChildValues(self.toDict())
         */
    }
}

extension Date {
    func toISO8601() -> String {
        let dateFormatter = DateFormatter()
        let enUSPosixLocale = Locale(identifier: "en_US_POSIX")
        dateFormatter.locale = enUSPosixLocale
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        let iso8601String = dateFormatter.string(from: self)
        
        return iso8601String
    }
}
