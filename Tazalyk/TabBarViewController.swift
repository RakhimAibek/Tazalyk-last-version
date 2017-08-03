//
//  TabBarViewController.swift
//  Tazalyk
//
//  Created by Aibek Rakhim on 7/28/17.
//  Copyright © 2017 Next Step. All rights reserved.
//

import UIKit
import FirebaseAuth

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: -Setting TabBat ViewControllers
        let mapVC = MapViewController()
        mapVC.view.backgroundColor = UIColor.lightGray
        mapVC.tabBarItem.image = UIImage(named: "mapIbar")
        mapVC.tabBarItem.selectedImage = UIImage(named: "mapIbarSelected")?.withRenderingMode(.alwaysOriginal)
        
        let rankingVC = RankingViewController()
        rankingVC.view.backgroundColor = UIColor.red
        rankingVC.tabBarItem.image = UIImage(named: "rankingIbar")
        rankingVC.tabBarItem.selectedImage = UIImage(named: "rankingIbarSelected")?.withRenderingMode(.alwaysOriginal)
        
        let profileVC = ProfileViewController()
        profileVC.view.backgroundColor = UIColor.green
        profileVC.tabBarItem.image = UIImage(named: "profileIbar")
        profileVC.tabBarItem.selectedImage = UIImage(named: "profileIbarSelected")?.withRenderingMode(.alwaysOriginal)
        
        self.viewControllers = [mapVC, rankingVC, profileVC]
    }
}
