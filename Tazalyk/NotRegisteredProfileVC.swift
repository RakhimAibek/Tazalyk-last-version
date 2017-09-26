//
//  NotRegisteredProfileVC.swift
//  Tazalyk
//
//  Created by Aibek Rakhim on 8/15/17.
//  Copyright © 2017 Next Step. All rights reserved.
//

import UIKit
import EasyPeasy

class NotRegisteredProfileVC: UIViewController {
    
    let profileTextLabel = UILabel()
    let infoLabel = UILabel()
    let signInButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureConstraints()
    }
    
    func configureView() {
        //setting navigation bar
        navigationItem.title = "Профиль"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "settings"), style: .plain, target: self, action: #selector(settingsButtonPressed(sender:)))
        navigationController?.navigationBar.tintColor = UIColor(red: 79.0/255.0, green: 87.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "ProximaNova-Bold", size: 18.0)!, NSForegroundColorAttributeName: UIColor(red: 79.0/255.0, green: 87.0/255.0, blue: 102.0/255.0, alpha: 1.0)]

        //Info label
        infoLabel.numberOfLines = 3
        infoLabel.textAlignment = .center
        infoLabel.text = "Для сохранения результатов и для получения бонусов потребуется профиль"
        infoLabel.font = UIFont(name: "ProximaNova-Semibold", size: 16.0)
        infoLabel.textColor = UIColor(red: 79.0/255.0, green: 87.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        
        //SignIn button
        signInButton.setTitle("Войти", for: .normal)
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.setTitleColor(UIColor(red: 219.0/255, green: 219.0/255, blue: 219.0/255, alpha: 0.7), for: .highlighted)
        signInButton.addTarget(self, action: #selector(signInBtnPressed), for: .touchUpInside)
        signInButton.titleLabel?.font = UIFont(name: "ProximaNova-Bold", size: 18.0)
        signInButton.backgroundColor = UIColor(red: 109.0/255.0, green: 168.0/255.0, blue: 207.0/255.0, alpha: 1.0)
        signInButton.layer.cornerRadius = 7.0
    
        [infoLabel, signInButton].forEach {
            self.view.addSubview($0)
        }
    }
    
    func configureConstraints() {
        infoLabel <- [
            CenterX(0.0),
            Top(214.0),
            Left(30.0),
            Right(30.0)
        ]
        
        signInButton <- [
            CenterX(0.0),
            Top(22.0).to(infoLabel),
            Left(30.0),
            Right(30.0),
            Height(48.0)
        ]
    }
    
    func settingsButtonPressed(sender: UIBarButtonItem) {
        let settingNavigationController = UINavigationController(rootViewController: SettingsViewController())
        settingNavigationController.view.backgroundColor = UIColor.white
        settingNavigationController.tabBarItem.image = UIImage(named: "profileIbar")
        settingNavigationController.tabBarItem.selectedImage = UIImage(named: "profileIbarSelected")?.withRenderingMode(.alwaysOriginal)
        self.present(settingNavigationController, animated: true, completion: nil)
    }
    
    func signInBtnPressed() {
        let loginVC = LoginViewController()
        self.present(loginVC, animated: true, completion: nil)
    }

}
