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
    
    init() {
        latitude = 0
        longitude = 0
        time = Date().toISO8601()
        disasterType = .other
        comment = ""
        otherDescription = ""
    }
    
    init(latitude: CLLocationDegrees, longitude: CLLocationDegrees, time: Date, disasterType: DisasterTypes, comment: String) {
        self.latitude = latitude
        self.longitude = longitude
        self.time = time.toISO8601()
        self.disasterType = disasterType
        self.comment = comment
    }
    
    init(fromDictionary dict: [String: Any]) {
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
                }
            default:
                print("error: defaulted")
            }
        }
        
        if let comment = dict["comment"] as? String {
            self.comment = comment
        }
    }
    
    init(fromSnapshot snapshot: DataSnapshot) {
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
                }
            default:
                print("error: defaulted")
            }
        }
        
        if let comment = snapshot.childSnapshot(forPath: "comment").value as? String {
            self.comment = comment
        }
    }
    
    func toDict() -> [String: Any] {
        return [
            "latitude" : latitude,
            "longitude" : longitude,
            "time" : time,
            "disasterType" : disasterType.rawValue,
            "comment" : comment,
            "otherDescription" : otherDescription
        ]
    }
}

extension Date {
    func toISO8601() -> String {
        let dateFormatter = DateFormatter()
        let enUSPosixLocale = Locale(identifier: "en_US_POSIX")
        dateFormatter.locale = enUSPosixLocale
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        let iso8601String = dateFormatter.string(from: Date())
        
        return iso8601String
    }
}
