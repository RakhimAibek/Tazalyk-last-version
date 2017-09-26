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
    
    var category: Category?
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var address: String?
    var timeTable: String?
    var contactInfo: String?
    var imageLink: String?
    var sales: String?
    
    init(title: String, coordinate: CLLocationCoordinate2D, category: Category, address: String, timeTable: String, contactInfo: String, imageLink: String, sales: String) {
        self.title = title
        self.category = category
        self.coordinate = coordinate
        self.address = address
        self.timeTable = timeTable
        self.contactInfo = contactInfo
        self.imageLink = imageLink
        self.sales = sales
    }
    
    init(dictionary: [String: Any]) {

        let coordinateData = dictionary["coordinate"] as? [String: Double]
        self.coordinate = CLLocationCoordinate2D(latitude: (coordinateData?["latitude"] ?? 0),
                                                 longitude: (coordinateData?["longtitude"] ?? 0))
        
        self.title = dictionary["title"] as? String
        category = Category(name:( dictionary["category"] as? String))
        self.address = dictionary["address"] as? String
        self.contactInfo = dictionary["contact"] as? String
        self.timeTable = dictionary["timeTable"] as? String
        self.imageLink = dictionary["imageLink"] as? String
        self.sales = dictionary["sales"] as? String
        
        super.init()
    }
    
    static func fetch(completion: @escaping (([Pin]?, String?) -> Void)) {
        Database.database().reference().child("Pins").observeSingleEvent(of: .value, with: { (snapshot) in
            
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
    }
}

