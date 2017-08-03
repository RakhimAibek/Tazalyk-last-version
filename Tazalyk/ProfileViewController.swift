//
//  ProfileViewController.swift
//  Tazalyk
//
//  Created by Aibek Rakhim on 8/3/17.
//  Copyright © 2017 Next Step. All rights reserved.
//

import UIKit
import EasyPeasy
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    let signOutButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureConstraints()
        
        if UserDefaults.standard.object(forKey: "userUID") == nil {
            signOutButton.isHidden = true
        }
    }
    
    func configureView() {
        signOutButton.backgroundColor = .black
        signOutButton.setTitle("Log out", for: .normal)
        signOutButton.setTitleColor(.white, for: .normal)
        signOutButton.setTitleColor(.blue, for: .highlighted)
        signOutButton.addTarget(self, action: #selector(logOutBTNpressed(sender:)), for: .touchUpInside)
        
        self.view.addSubview(signOutButton)
    }
    
    func configureConstraints() {
        signOutButton <- [
            CenterX(0.0),
            CenterY(0.0)
        ]
    }
    
    func logOutBTNpressed(sender: UIButton) {
        do {
            try Auth.auth().signOut()
            
            if Auth.auth().currentUser == nil {
                UserDefaults.standard.removeObject(forKey: "userUID")
                UserDefaults.standard.synchronize()
                
                let firstVC = FirstViewController()
                present(firstVC, animated: true, completion: nil)
            }
        } catch let signOutError as NSError {
            print(signOutError.localizedDescription)
        }
    }
}
