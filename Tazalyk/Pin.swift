//
//  Pins.swift
//  Tazalyk
//
//  Created by Aibek Rakhim on 8/1/17.
//  Copyright © 2017 Next Step. All rights reserved.

import Foundation
import MapKit
import FirebaseDatabase

class Pin: NSObject, MKAnnotation {
    
    var categories: String?
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var address: String?
    var timetable: String?
    var contact: String?
    var imageLink: String?
    var sale: String?
    
    init(title: String, coordinate: CLLocationCoordinate2D, categories: String, address: String, timetable: String, contact: String, imageLink: String, sale: String) {
        self.title = title
        self.categories = categories
        self.coordinate = coordinate
        self.address = address
        self.timetable = timetable
        self.contact = contact
        self.imageLink = imageLink
        self.sale = sale
    }
    
    init(dictionary: [String: Any]) {

        let coordinateData = dictionary["coordinate"] as? [String: Double]
        self.coordinate = CLLocationCoordinate2D(latitude: (coordinateData?["lat"] ?? 0),
                                                 longitude: (coordinateData?["long"] ?? 0))
        self.title = dictionary["title"] as? String
        categories = dictionary["categories"] as? String
        self.address = dictionary["address"] as? String
        self.contact = dictionary["contact"] as? String
        self.timetable = dictionary["timetable"] as? String
        self.imageLink = dictionary["imageLink"] as? String
        self.sale = dictionary["sale"] as? String
        
        super.init()
    }
    
    static func fetch(completion: @escaping (([Pin]?, String?) -> Void)) {
        Database.database().reference().child("Pins").observe(.value, with: { (snapshot) in

            if let pinsDict = snapshot.value as? [String: [String: Any]] {
                var pins = [Pin]()
                for i in pinsDict {
                    let pin = Pin(dictionary: i.value)
                    pins.append(pin)
                }
                completion(pins, nil)
                return
            }

            completion(nil, "Fetching error occured")
        })
        
//        Database.database().reference().child("Pins").observeSingleEvent(of: .value, with: { (snapshot) in
//
//            if let pinsDict = snapshot.value as? [String: [String: Any]] {
//                var pins = [Pin]()
//                for i in pinsDict {
//                    let pin = Pin(dictionary: i.value)
//                    pins.append(pin)
//                }
//                completion(pins, nil)
//                return
//            }
//
//            completion(nil, "Fetching error occured")
//        })

        
    }
}

