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
    
    init() {
        latitude = 0
        longitude = 0
        time = ""
        disasterType = .other
        comment = ""
    }
    
    init(latitude: CLLocationDegrees, longitude: CLLocationDegrees, time: Date, disasterType: DisasterTypes, comment: String) {
        self.latitude = latitude
        self.longitude = longitude
        self.time = time.toISO8601()
        self.disasterType = disasterType
        self.comment = comment
    }
    
    func toDict() -> [String: Any] {
        return [
            "latitude" : latitude,
            "longitude" : longitude,
            "time" : time,
            "disasterType" : disasterType.rawValue,
            "comment": comment
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
