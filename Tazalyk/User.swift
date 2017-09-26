//
//  User.swift
//  Tazalyk
//
//  Created by Aibek Rakhim on 8/12/17.
//  Copyright © 2017 Next Step. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class User
{
    var userName: String?
    var phoneNumber: String?
    var userRole: String?
    var status: String?
    var bonus: Int?
    var address: String?
    var totalPassed: Int?
    var goalNumber: Int?
    
    init(userName: String, phoneNumber: String, userRole: String, status: String, bonus: Int, totalPassed: Int, goalNumber: Int) {
        self.userName = userName
        self.phoneNumber = phoneNumber
        self.userRole = userRole
        self.status = status
        self.bonus = bonus
        self.totalPassed = totalPassed
        self.goalNumber = goalNumber
    }
    
    init(snapshot: DataSnapshot){
        
        let data = snapshot.value as? NSDictionary
        self.userName = data?["userName"] as? String ?? ""
        self.phoneNumber = data?["PhoneNumber"] as? String ?? ""
        self.userRole = data?["userRole"] as? String ?? ""
        self.bonus = data?["Bonus"] as? Int ?? 0
        self.status = data?["Status"] as? String ?? ""
        self.totalPassed = data?["Total"] as? Int ?? 0
        self.goalNumber = data?["Goal"] as? Int ?? 0

    }
    
    static func fetch(completion: @escaping (([User]?, String?) -> Void)) {
        
        if UserDefaults.standard.object(forKey: "userUID") != nil {
        let userUid = Auth.auth().currentUser?.uid
            
        Database.database().reference().child("Users").child(userUid!).observe(.value, with: { (snapshot) in
            
            if let data = snapshot.value as? [String: Any] {
                
                var resultArray: [User] = []
                
                let userName = data["userName"] as? String ?? ""
                let phoneNumber = data["PhoneNumber"] as? String ?? ""
                let userRole = data["userRole"] as? String ?? ""
                let userBonus = data["Bonus"] as? Int ?? 0
                let userStatus = data["Status"] as? String ?? ""
                let totalPassed = data["Total"] as? Int ?? 0
                let goalNumber = data["Goal"] as? Int ?? 0
                
                let castedObject = User(userName: userName, phoneNumber: phoneNumber, userRole: userRole, status: userStatus, bonus: userBonus, totalPassed: totalPassed, goalNumber: goalNumber)
                
                resultArray.append(castedObject)
                completion(resultArray, nil)
                
            } else {
                
                completion(nil, "User fetch error")
            }
            
        })
        }
    }
}
