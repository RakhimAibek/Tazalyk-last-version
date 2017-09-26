//
//  ProfileVC+configureView.swift
//  Tazalyk
//
//  Created by Aibek Rakhim on 8/11/17.
//  Copyright © 2017 Next Step. All rights reserved.
//

import Foundation
import EasyPeasy
import UIKit

extension ProfileViewController {
    
    func configureView() {
        //UIButton
        settingsButton.setImage(UIImage(named: "settings"), for: .normal)
        settingsButton.addTarget(self, action: #selector(settingsButtonPressed(sender:)), for: .touchUpInside)
        
        //UserName UILabel
        userNameLabel.font = UIFont(name: "ProximaNova-Bold", size: 18.0)
        userNameLabel.textColor = UIColor.black
        userNameLabel.text = ""
        
        //UserStatus UILabel
        userStatusLabel.text = "Статус:"
        userStatusLabel.numberOfLines = 2
        userStatusLabel.font = UIFont(name: "ProximaNova-Bold", size: 12.0)
        userStatusLabel.textColor = UIColor(red: 79.0/255.0, green: 87.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        
        //UserBonus UILabel
        userBonusLabel.text = "Бонусы:"
        userBonusLabel.font = UIFont(name: "ProximaNova-Bold", size: 12.0)
        userBonusLabel.textColor = UIColor(red: 79.0/255.0, green: 87.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        
        //Info yourStatistic
        yourStatisticLabel.text = "Ваша статистика"
        yourStatisticLabel.textColor = UIColor(red: 79.0/255.0, green: 87.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        yourStatisticLabel.font = UIFont(name: "ProximaNova-Bold", size: 16.0)
        
        //Lines under text
        firstLine.backgroundColor = UIColor(red: 234.0/255.0, green: 234.0/255.0, blue: 234.0/255.0, alpha: 1.0)
        secondLine.backgroundColor = UIColor(red: 234.0/255.0, green: 234.0/255.0, blue: 234.0/255.0, alpha: 1.0)
        thirdLine.backgroundColor = UIColor(red: 234.0/255.0, green: 234.0/255.0, blue: 234.0/255.0, alpha: 1.0)
        
        //Circle ProgressView
        circleProgressView.progress = 0.3
        circleProgressView.roundedCap = true
        circleProgressView.trackWidth = 12.0
        circleProgressView.trackBackgroundColor = UIColor(red: 234.0/255.0, green: 233.0/255.0, blue: 241, alpha: 1.0)
        circleProgressView.trackFillColor = UIColor(red: 136.0/255.0, green: 192.0/255.0, blue: 65.0/255.0, alpha: 1.0)
        circleProgressView.backgroundColor = UIColor.white
        
        //Total number of trash - UILabel
        totalNumberLabel.text = ""
        totalNumberLabel.textColor = .black
        totalNumberLabel.font = UIFont(name: "ProximaNova-Bold", size: 20.0)
        self.circleProgressView.addSubview(totalNumberLabel)
        self.circleProgressView.addSubview(infoTextPassed)
        
        //InfoTextPassed UILabel
        infoTextPassed.text = "сдано"
        infoTextPassed.textColor = UIColor(red: 79.0/255.0, green: 87.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        infoTextPassed.font = UIFont(name: "ProximaNova-Regular", size: 14.0)
        
        //Info Saved Text
        youSavedLabel.text = "Вы спасли:"
        youSavedLabel.textColor = UIColor(red: 79.0/255.0, green: 87.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        youSavedLabel.font = UIFont(name: "ProximaNova-Bold", size: 14.0)
        
        //Tree ImageView
        treeImageView.image = UIImage(named: "trees")
        //Number of Trees UILabel
        numberOfTreesLabel.text = ""
        numberOfTreesLabel.font = UIFont(name: "ProximaNova-Bold", size: 14.0)
        numberOfTreesLabel.textColor = UIColor(red: 79.0/255.0, green: 87.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        
        //DropWater imageView
        dropWaterImage.image = UIImage(named: "dropWater")
        //Number of litres of waster UILabel
        numberOfWaterLabel.text = ""
        numberOfWaterLabel.font = UIFont(name: "ProximaNova-Bold", size: 14.0)
        numberOfWaterLabel.textColor = UIColor(red: 79.0/255.0, green: 87.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        
        //Lamp imageView
        lampImageView.image = UIImage(named: "lamp")
        //NumberOfElectro UILabel
        numberOfElectroLabel.text = ""
        numberOfElectroLabel.font = UIFont(name: "ProximaNova-Bold", size: 14.0)
        numberOfElectroLabel.textColor = UIColor(red: 79.0/255.0, green: 87.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        
        //GoalTextSection
        goalTextLabel.text = "Текущая цель"
        goalTextLabel.textColor = UIColor(red: 79.0/255.0, green: 87.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        goalTextLabel.font = UIFont(name: "ProximaNova-Bold", size: 16.0)
        
        //GoalNumber
        goalNumberLabel.text = ""
        goalNumberLabel.textColor = .black
        goalNumberLabel.font = UIFont(name: "ProximaNova-Bold", size: 20.0)
        
        //Share Section
        shareTextLabel.text = "Поделись с друзьями"
        shareTextLabel.textColor = UIColor(red: 79.0/255.0, green: 87.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        shareTextLabel.font = UIFont(name: "ProximaNova-Bold", size: 16.0)
        facebookLogoButton.setImage(UIImage(named: "facebook"), for: .normal)
        facebookLogoButton.addTarget(self, action: #selector(facebookBTNpressed(sender:)), for: .touchUpInside)
        
        facebookTextButton.setTitle("Facebook", for: .normal)
        facebookTextButton.setTitleColor(UIColor(red: 79.0/255.0, green: 87.0/255.0, blue: 102.0/255.0, alpha: 1.0), for: .normal)
        facebookTextButton.setTitleColor(UIColor(red: 219.0/255, green: 219.0/255, blue: 219.0/255, alpha: 0.7), for: .highlighted)
        facebookTextButton.titleLabel?.font = UIFont(name: "ProximaNova-Bold", size: 14.0)
        facebookTextButton.addTarget(self, action: #selector(facebookBTNpressed(sender:)), for: .touchUpInside)
        facebookTextButton.backgroundColor = .clear
        
        [settingsButton, userNameLabel, userStatusLabel, userBonusLabel, yourStatisticLabel, firstLine, circleProgressView, youSavedLabel, treeImageView, numberOfTreesLabel, dropWaterImage, numberOfWaterLabel, lampImageView, numberOfElectroLabel, goalTextLabel, secondLine, goalNumberLabel, shareTextLabel, thirdLine, facebookLogoButton, facebookTextButton].forEach {
            self.view.addSubview($0)
        }
    }
    
    func configureConstraints() {
        settingsButton <- [
            Top(35.0),
            Right(20.0),
            Height(20.0),
            Width(20.0)
        ]

        userNameLabel <- [
            Top(35.0),
            Left(20.0),
            Height(22.0)
        ]
        
        userStatusLabel <- [
            Top(7.0).to(userNameLabel),
            Left(20.0)
        ]
        
        userBonusLabel <- [
            Top(7.0).to(userStatusLabel),
            Left(20.0)
        ]
        
        yourStatisticLabel <- [
            Top(39.0).to(userBonusLabel),
            Left(20.0),
            Height(20.0)
        ]
        
        firstLine <- [
            Top(5.0).to(yourStatisticLabel),
            Left(20.0),
            Right(20.0),
            Height(1.0)
        ]
        
        secondLine <- [
            Top(5.0).to(goalTextLabel),
            Left(20.0),
            Right(20.0),
            Height(1.0)
        ]
        
        thirdLine <- [
            Top(5.0).to(shareTextLabel),
            Left(20.0),
            Right(20.0),
            Height(1.0)
        ]
        
        circleProgressView <- [
            Height(120.0),
            Width(120.0),
            Top(20.0).to(firstLine),
            Left(20.0)
        ]
        
        youSavedLabel <- [
            Top(34.0).to(firstLine),
            Left(85.0).to(circleProgressView)
            
        ]
        
        treeImageView <- [
            Top(8.0).to(youSavedLabel),
            Left(85.0).to(circleProgressView),
            Height(16.0),
            Width(12.0)
        ]
        
        numberOfTreesLabel <- [
            Top(8.0).to(youSavedLabel),
            Left(5.0).to(treeImageView)
        ]
        
        dropWaterImage <- [
            Top(8.0).to(treeImageView),
            Left(85.0).to(circleProgressView),
            Height(16.0),
            Width(12)
        ]
        
        numberOfWaterLabel <- [
            Top(8.0).to(numberOfTreesLabel),
            Left(5.0).to(dropWaterImage)
        ]
        
        lampImageView <- [
            Top(8.0).to(dropWaterImage),
            Left(85.0).to(circleProgressView),
            Height(16.0),
            Width(10.4)
        ]
        
        numberOfElectroLabel <- [
            Top(8.0).to(numberOfWaterLabel),
            Left(5.0).to(lampImageView)
        ]
        
        totalNumberLabel <- [
            CenterX(0.0),
            CenterY(0.0)
        ]
        
        infoTextPassed <- [
            Top().to(totalNumberLabel),
            CenterX(0.0)
        ]
        
        goalTextLabel <- [
            Top(30.0).to(circleProgressView),
            Left(20.0)
        ]
        
        goalNumberLabel <- [
            Top(29.0).to(circleProgressView),
            Left(85.0).to(circleProgressView)
        ]
        
        shareTextLabel <- [
            Top(30.0).to(secondLine),
            Left(20.0)
        ]
        
        facebookLogoButton <- [
            Top(13.0).to(thirdLine),
            Left(20.0),
            Height(20.0),
            Width(20.0)
        ]
        
        facebookTextButton <- [
            Top(8.0).to(thirdLine),
            Left(14.0).to(facebookLogoButton)
            
        ]
    }
}
