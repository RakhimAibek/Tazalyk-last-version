//
//  FirstVC+handler.swift
//  Tazalyk
//
//  Created by Aibek Rakhim on 8/3/17.
//  Copyright © 2017 Next Step. All rights reserved.
//

import Foundation
import UIKit

extension FirstViewController {
    
    func loginButtonPressed() {
        let loginVC = LoginViewController()
        present(loginVC, animated: true, completion: nil)
    }
    
    func missButtonPressed() {
        let tabBarVC = TabBarViewController()
        present(tabBarVC, animated: true, completion: nil)
    }
}
