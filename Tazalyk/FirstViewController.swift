//
//  ViewController.swift
//  Tazalyk
//
//  Created by Aibek Rakhim on 7/21/17.
//  Copyright © 2017 Next Step. All rights reserved.

import UIKit
import EasyPeasy

class FirstViewController: UIViewController {

    let logoImage = UIImageView()
    let loginButton = UIButton()
    let bgImage = UIImageView()
    let missButton = UIButton()
    let labelText = UILabel()
    let bgShadow = UIView()

    var gradientLayer: CAGradientLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        createGradientLayer()
        view.backgroundColor = UIColor.white
        
        UIApplication.shared.statusBarStyle = .lightContent

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if UserDefaults.standard.object(forKey: "userUID") != nil {
            let tabBarVC = TabBarViewController()
            present(tabBarVC, animated: false, completion: nil)
        }
        
        if UserDefaults.standard.object(forKey: "adminRole") != nil {
            let adminVC = AdminViewController()
            present(adminVC, animated: true, completion: nil)
        }
    }
    
    func createGradientLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradientLayer.locations = [0, 1]
        self.bgShadow.layer.addSublayer(gradientLayer)
    }
    
    func setupViews() {
        
        //BackgroundImage
        bgImage.image = UIImage(named: "astanaCity")
        bgImage.contentMode = .scaleAspectFill
        
        //ShadowMaskView
        bgShadow.alpha = 0.65
        
        //LogoImageView
        logoImage.image = UIImage(named: "whiteLogo")
        
        //LabelText
        labelText.text = "Сдавая мусор в пункты приема, Вы делаете свой город чище!"
        labelText.font = UIFont(name: "ProximaNova-Semibold", size: 16)
        labelText.numberOfLines = 0
        labelText.textColor = UIColor.white

        //LoginButton
        loginButton.backgroundColor = UIColor(red: 109.0/255.0, green: 168.0/255.0, blue: 207.0/255.0, alpha: 0.90)
        loginButton.layer.cornerRadius = 7.0
        loginButton.setTitle("Войти", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = UIFont(name: "ProximaNova-Bold", size: 16.0)
        loginButton.setTitleColor(UIColor(red: 219.0/255, green: 219.0/255, blue: 219.0/255, alpha: 0.7), for: .highlighted)
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        
        //MissButton
        missButton.setTitleColor(UIColor(red: 219.0/255, green: 219.0/255, blue: 219.0/255, alpha: 0.7), for: .highlighted)
        missButton.setTitleColor(UIColor.white, for: .normal)
        missButton.titleLabel?.font = UIFont(name: "ProximaNova-Semibold", size: 16.0)
        missButton.setTitle("Позже", for: .normal)
        missButton.addTarget(self, action: #selector(missButtonPressed), for: .touchUpInside)
        
        //adding UIElements to superView
        [bgImage, bgShadow, logoImage, labelText, loginButton, missButton].forEach {
            view.addSubview($0)
        }
        
    }
    func setupConstraints() {
        
        //BgImage
        bgImage <- Edges()
        
        //BgShadowMask
        bgShadow <- Edges()
        
        //LogoImage
        logoImage <- [
            Size(CGSize(width: 209.0, height: 50.0)),
            CenterX(0.0),
            Top(76.0)
            ].when { $0.isPhone }
        
        //Label
        labelText <- [
            Top(15.0).to(logoImage),
            Width(244.0),
            Height(40.0),
            CenterX(0.0)
        ].when { $0.isPhone }
        
        //LoginButton
        loginButton <- [
            CenterX(0.0),
            CenterY(89.0),
            Left(59.0),
            Right(59.0),
            Height(48.0)
        ]
        
        //MissButton
        missButton <- [
            CenterX(0.0),
            Bottom(15.0).to(view)
        ]
    
    }
}

