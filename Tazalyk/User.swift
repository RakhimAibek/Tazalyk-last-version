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
    var bonus: Int?
    var total: Int?
    
    init(userName: String, phoneNumber: String, userRole: String, bonus: Int, total: Int) {
        self.userName = userName
        self.phoneNumber = phoneNumber
        self.userRole = userRole
        self.bonus = bonus
        self.total = total
    }
    
    init(snapshot: DataSnapshot){
        
        let data = snapshot.value as? NSDictionary
        self.userName = data?["userName"] as? String ?? ""
        self.phoneNumber = data?["phoneNumber"] as? String ?? ""
        self.userRole = data?["userRole"] as? String ?? ""
        self.bonus = data?["bonus"] as? Int ?? 0
        self.total = data?["total"] as? Int ?? 0
    }
    
    static func fetch(completion: @escaping (([User]?, String?) -> Void)) {
        
        if UserDefaults.standard.object(forKey: "userUID") != nil {
        let userUid = Auth.auth().currentUser?.uid
            
        Database.database().reference().child("Users").child(userUid!).observe(.value, with: { (snapshot) in
            
            if let data = snapshot.value as? [String: Any] {
                
                var resultArray: [User] = []
                
                let userName = data["userName"] as? String ?? ""
                let phoneNumber = data["phoneNumber"] as? String ?? ""
                let userRole = data["userRole"] as? String ?? ""
                let userBonus = data["bonus"] as? Int ?? 0
                let totalPassed = data["total"] as? Int ?? 0
                
                let castedObject = User(userName: userName, phoneNumber: phoneNumber, userRole: userRole, bonus: userBonus, total: totalPassed)
                
                resultArray.append(castedObject)
                completion(resultArray, nil)
                
            } else {
                
                completion(nil, "User fetch error")
            }
            
        })
        }
    }

}
