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
    
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var ref: DatabaseReference?
    var category: Category?
    
    init(title: String, coordinate: CLLocationCoordinate2D, category: Category) {
        self.title = title
        self.coordinate = coordinate
        self.category = category
    }
    
    override init() {
        //empty
        self.title = ""
        self.coordinate = CLLocationCoordinate2DMake(0, 0)
        self.ref = nil
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as? [String: AnyObject] ?? [:]
        self.title = snapshotValue["title"] as? String ?? ""
        let coordinateData = snapshotValue["coordinate"] as? [String: Any] ?? [:]
        let coordinateLatitude = coordinateData["latitude"] as? CLLocationDegrees ?? 0
        let coordinateLongtitude = coordinateData["longtitude"] as? CLLocationDegrees ?? 0
        self.coordinate = CLLocationCoordinate2DMake(coordinateLatitude, coordinateLongtitude)
    }
    
    static func fetch(completion: @escaping (([Category]?, String?) -> Void)) {
        Database.database().reference().child("Pins").observeSingleEvent(of: .value, with: { (snapshot) in
            if let data = snapshot.value as? [String: String] {
                var resultArray: [Category] = []
                for i in data {
                    let castedObject = Category(name: i.value)
                    resultArray.append(castedObject)
                }
                completion(resultArray, nil)
            } else {
                completion(nil, "fetch function error")
            }
        })
    }

    
    
    
//    static func loadPlaces() -> [Pin] {
//        return [
//            Pin(title: "Прием макулатуры", coordinate: CLLocationCoordinate2DMake(51.161098, 71.484139)),
//            Pin(title: "Прием пластика", coordinate: CLLocationCoordinate2DMake(51.126806, 71.472631))
//        ]
//    }
}

