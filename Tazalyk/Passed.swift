//
//  Passed.swift
//  Tazalyk
//
//  Created by Aibek Rakhim on 8/18/17.
//  Copyright © 2017 Next Step. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class Passed {
    
    var whoPassed: String?
    var bonus: Int?
    var whenPassed: String?
    
    init(whoPassed: String,bonus: Int, whenPassed: String) {
        self.whoPassed = whoPassed
        self.bonus = bonus
        self.whenPassed = whenPassed
    }
    
    static func fetch(completion: @escaping (([Passed]?, String?) -> Void)) {
        
        if let authPhoneNumber = Auth.auth().currentUser?.phoneNumber {

        Database.database().reference().child("Passed").child(authPhoneNumber).observe(.value, with: { (snapshot) in
            
            if let data = snapshot.value as? [DataSnapshot] {
                for snap in data {
                    
                    if let data = snap.value as? [String: Any] {
                        
                        var resultArray: [Passed] = []
                        
                        let whoPassed = data["whoPassed"] as? String ?? ""
                        let bonus = data["Bonus"] as? Int ?? 0
                        let whenPassed = data["whenPassed"] as? String ?? ""
                        
                        let castedObject = Passed(whoPassed: whoPassed, bonus: bonus, whenPassed: whenPassed)
                        
                        resultArray.append(castedObject)
                        completion(resultArray, nil)
                        
                    } else {
                        completion(nil, "User fetch error")
                    }
                }
            }

            
        })
    }
}
}
