//
//  TypeWaste.swift
//  Tazalyk
//
//  Created by Aibek Rakhim on 8/1/17.
//  Copyright © 2017 Next Step. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Category: NSObject {
    
    let name: String?
    
    init(name: String?) {
        self.name = name
    }
    
    static func fetch(completion: @escaping (([Category]?, String?) -> Void)) {
        Database.database().reference().child("Category").observeSingleEvent(of: .value, with: { (snapshot) in
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
}
