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
    
    init(dictionary: [String: Any]) {
        self.title = dictionary["title"] as? String
        
        let coordinateData = dictionary["coordinate"] as? [String: Double]
        self.coordinate = CLLocationCoordinate2D(latitude: (coordinateData?["latitude"] ?? 0),
                                                 longitude: (coordinateData?["longtitude"] ?? 0))
        category = Category(name:( dictionary["category"] as? String))
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

    
    
    
//    static func loadPlaces() -> [Pin] {
//        return [
//            Pin(title: "Прием макулатуры", coordinate: CLLocationCoordinate2DMake(51.161098, 71.484139)),
//            Pin(title: "Прием пластика", coordinate: CLLocationCoordinate2DMake(51.126806, 71.472631))
//        ]
//    }
}

