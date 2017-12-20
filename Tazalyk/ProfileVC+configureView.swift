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
        userNameLabel.font = UIFont(name: "ProximaNova-Bold", size: 20.0)
        userNameLabel.textColor = UIColor.black
        userNameLabel.text = "Дана Солтанова"
        if self.view.frame.width == 414 {
            userNameLabel.font = UIFont(name: "ProximaNova-Bold", size: 22)
        }
        //userPhoto
        userPhoto.image = UIImage(named: "userPhoto")
        userPhoto.isUserInteractionEnabled = true
        avatarTap.addTarget(self, action: #selector(fusumaMethod))
        userPhoto.addGestureRecognizer(avatarTap)
        
        //UserStatus UILabel
        userStatusLabel.text = "Ваш Статус: Заботливый"
        userStatusLabel.numberOfLines = 1
        userStatusLabel.textColor = UIColor(red: 79.0/255.0, green: 87.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        var size:CGFloat = 0
        if view.frame.width == 375 || view.frame.width == 414 {
            size = 16
        } else if view.frame.width == 320 {
            size = 14
        }
        userStatusLabel.font = UIFont(name: "ProximaNova-Bold", size: size)
    
        //UserBonus UILabel
        userBonusLabel.text = "Бонусы: 60"
        userBonusLabel.textColor = UIColor(red: 79.0/255.0, green: 87.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        userBonusLabel.font = UIFont(name: "ProximaNova-Bold", size: size)
        
        //Info yourStatistic
        yourStatisticLabel.text = "Ваша эко-статистика"
        yourStatisticLabel.textColor = UIColor(red: 79.0/255.0, green: 87.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        var size1:CGFloat = 0
        if view.frame.width == 375 || view.frame.width == 320 {
            size1 = 16
        } else if view.frame.width == 414 {
            size1 = 18
        }
        yourStatisticLabel.font = UIFont(name: "ProximaNova-Bold", size: size1)
        
        //Lines under text
        firstLine.backgroundColor = UIColor(red: 234.0/255.0, green: 234.0/255.0, blue: 234.0/255.0, alpha: 1.0)
        secondLine.backgroundColor = UIColor(red: 234.0/255.0, green: 234.0/255.0, blue: 234.0/255.0, alpha: 1.0)
        thirdLine.backgroundColor = UIColor(red: 234.0/255.0, green: 234.0/255.0, blue: 234.0/255.0, alpha: 1.0)
        
        //Circle ProgressView
        circleProgressView.progress = -0.8
        circleProgressView.roundedCap = true
        circleProgressView.trackWidth = 9
        circleProgressView.trackBackgroundColor = UIColor(red: 234.0/255.0, green: 233.0/255.0, blue: 241, alpha: 1.0)
        circleProgressView.trackFillColor = UIColor(red: 136.0/255.0, green: 192.0/255.0, blue: 65.0/255.0, alpha: 1.0)
        circleProgressView.backgroundColor = UIColor.white
        
        
        //Total number of trash - UILabel
        totalNumberLabel.text = "Ваш вклад: 60кг"
        totalNumberLabel.textColor = UIColor(red: 79.0/255.0, green: 87.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        totalNumberLabel.font = UIFont(name: "ProximaNova-Bold", size: size)
        
        //Info Saved Text
        youSavedLabel.text = "Вы спасли:"
        youSavedLabel.textColor = UIColor(red: 79.0/255.0, green: 87.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        youSavedLabel.font = UIFont(name: "ProximaNova-Bold", size: size1)
        
        //Tree ImageView
        treeImageView.image = UIImage(named: "trees")
        //Number of Trees UILabel
        numberOfTreesLabel.text = "1"
        var size2:CGFloat = 0
        if view.frame.width == 320 || view.frame.width == 375 {
            size2 = 14
        } else if view.frame.width == 414 {
            size2 = 16
        }
        numberOfTreesLabel.font = UIFont(name: "ProximaNova-Semibold", size: size2)
        numberOfTreesLabel.textColor = UIColor(red: 79.0/255.0, green: 87.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        
        //DropWater imageView
        dropWaterImage.image = UIImage(named: "dropWater")
        //Number of litres of waster UILabel
        numberOfWaterLabel.text = "1200 л"
        numberOfWaterLabel.font = UIFont(name: "ProximaNova-Semibold", size: size2)
        numberOfWaterLabel.textColor = UIColor(red: 79.0/255.0, green: 87.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        
        //Lamp imageView
        lampImageView.image = UIImage(named: "lamp")
        //NumberOfElectro UILabel
        numberOfElectroLabel.text = "60 квт"
        numberOfElectroLabel.font = UIFont(name: "ProximaNova-Semibold", size: size2)
        numberOfElectroLabel.textColor = UIColor(red: 79.0/255.0, green: 87.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        
        //GoalTextSection
        goalTextLabel.text = "До следующего\nстатуса"
        goalTextLabel.textAlignment = .center
        goalTextLabel.numberOfLines = 2
        goalTextLabel.textColor = UIColor(red: 79.0/255.0, green: 87.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        goalTextLabel.font = UIFont(name: "ProximaNova-Bold", size: size1)
        
        //GoalNumber
        goalNumberLabel.text = "40 кг"
        goalNumberLabel.textColor = .black
        goalNumberLabel.font = UIFont(name: "ProximaNova-Bold", size: size1)
        
        //Share Section
        shareTextLabel.text = "Поделитесь с друзьями"
        shareTextLabel.textColor = UIColor(red: 79.0/255.0, green: 87.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        shareTextLabel.font = UIFont(name: "ProximaNova-Bold", size: size1)
        
        //social share
        facebookLogoButton.setImage(UIImage(named: "facebook"), for: .normal)
        facebookLogoButton.addTarget(self, action: #selector(facebookBTNpressed(sender:)), for: .touchUpInside)
        facebookTextButton.setTitle("Facebook", for: .normal)
        facebookTextButton.setTitleColor(UIColor(red: 79.0/255.0, green: 87.0/255.0, blue: 102.0/255.0, alpha: 1.0), for: .normal)
        facebookTextButton.setTitleColor(UIColor(red: 219.0/255, green: 219.0/255, blue: 219.0/255, alpha: 0.7), for: .highlighted)
        facebookTextButton.titleLabel?.font = UIFont(name: "ProximaNova-Bold", size: size)
        facebookTextButton.addTarget(self, action: #selector(facebookBTNpressed(sender:)), for: .touchUpInside)
        facebookTextButton.backgroundColor = .clear
        
        instagramLogoButton.setImage(UIImage(named: "instagram"), for: .normal)
        instagramLogoButton.addTarget(self, action: #selector(instagramBTNpressed(sender:)), for: .touchUpInside)
        instagramTextButton.addTarget(self, action: #selector(instagramBTNpressed(sender:)), for: .touchUpInside)
        instagramTextButton.setTitle("Instagram", for: .normal)
        instagramTextButton.setTitleColor(UIColor(red: 79.0/255.0, green: 87.0/255.0, blue: 102.0/255.0, alpha: 1.0), for: .normal)
        instagramTextButton.setTitleColor(UIColor(red: 219.0/255, green: 219.0/255, blue: 219.0/255, alpha: 0.7), for: .highlighted)
        instagramTextButton.titleLabel?.font = UIFont(name: "ProximaNova-Bold", size: size)
        instagramTextButton.backgroundColor = .clear
        
        centerImageView.contentMode = .scaleAspectFit
        
        [settingsButton, userNameLabel, userStatusLabel, totalNumberLabel ,userBonusLabel, yourStatisticLabel, firstLine, circleProgressView, youSavedLabel, treeImageView, numberOfTreesLabel, dropWaterImage, numberOfWaterLabel, lampImageView, numberOfElectroLabel, goalTextLabel, secondLine, goalNumberLabel, shareTextLabel, thirdLine, facebookLogoButton, facebookTextButton, instagramLogoButton, instagramTextButton, userPhoto, centerImageView].forEach {
            self.view.addSubview($0)
        }
    }
    
    func configureConstraints() {
        
        //Setting for iphone 6,7,8
        settingsButton <- [
            Top(40.0),
            Right(15.0),
            Height(24.0),
            Width(24.0)
        ].when({ () -> Bool in
                return self.view.frame.width == 375 || self.view.frame.width == 320
        })

        userNameLabel <- [
            Top(40.0),
            CenterX(0).to(view)
        ].when({ () -> Bool in
                return self.view.frame.width == 375 || self.view.frame.width == 320
        })
        
        userPhoto <- [
            Top(20).to(userNameLabel),
            Left(20),
            Height(111),
            Width(110)
        ].when({ () -> Bool in
                return self.view.frame.width == 375
        })
        
        userStatusLabel <- [
            Top(40.0).to(userNameLabel),
            Left(15.0).to(userPhoto)
        ].when({ () -> Bool in
                return self.view.frame.width == 375
        })
        
        totalNumberLabel <- [
            Top(5).to(userStatusLabel),
            Left(15).to(userPhoto)
        ].when({ () -> Bool in
                return self.view.frame.width == 375
        })

        userBonusLabel <- [
            Top(5).to(totalNumberLabel),
            Left(15).to(userPhoto)
        ].when({ () -> Bool in
                return self.view.frame.width == 375
        })
        
        yourStatisticLabel <- [
            Top(25).to(userPhoto),
            Left(20),
            Right(20)
        ].when({ () -> Bool in
                return self.view.frame.width == 375 || self.view.frame.width == 320
        })
        
        firstLine <- [
            Top(5.0).to(yourStatisticLabel),
            Left(20.0),
            Right(20.0),
            Height(1.0)
        ].when({ () -> Bool in
                return self.view.frame.width == 375 || self.view.frame.width == 320
        })
        
        circleProgressView <- [
            Height(111),
            Width(110),
            Top(15).to(firstLine),
            Left(20)
        ].when({ () -> Bool in
                return self.view.frame.width == 375
        })
        
        centerImageView <- [
            Height(95),
            Width(95),
            CenterX(0).to(circleProgressView),
            CenterY(0).to(circleProgressView)
            ].when({ () -> Bool in
                return self.view.frame.width == 375
            })
        
        youSavedLabel <- [
            Top(20).to(firstLine),
            Left(95).to(circleProgressView)
            ].when({ () -> Bool in
                return self.view.frame.width == 375
        })
        
        treeImageView <- [
            Top(8.0).to(youSavedLabel),
            Left(95).to(circleProgressView),
            Height(16.0),
            Width(12.0)
            ].when({ () -> Bool in
                return self.view.frame.width == 375
            })
        
        numberOfTreesLabel <- [
            Top(8.0).to(youSavedLabel),
            Left(5.0).to(treeImageView)
            ].when({ () -> Bool in
                return self.view.frame.width == 375
            })
        
        dropWaterImage <- [
            Top(8.0).to(treeImageView),
            Left(95).to(circleProgressView),
            Height(16.0),
            Width(12.0)
            ].when({ () -> Bool in
                return self.view.frame.width == 375
            })
        
        numberOfWaterLabel <- [
            Top(8.0).to(numberOfTreesLabel),
            Left(5.0).to(dropWaterImage)
            ].when({ () -> Bool in
                return self.view.frame.width == 375
            })
        
        lampImageView <- [
            Top(8.0).to(dropWaterImage),
            Left(95).to(circleProgressView),
            Height(16.0),
            Width(11)
        ].when({ () -> Bool in
                return self.view.frame.width == 375
        })
        
        numberOfElectroLabel <- [
            Top(8.0).to(numberOfWaterLabel),
            Left(5.0).to(lampImageView)
            ].when({ () -> Bool in
                return self.view.frame.width == 375
            })
        
        goalTextLabel <- [
            Top(25).to(circleProgressView),
            Left(20.0),
            Width(125)
            ].when({ () -> Bool in
                return self.view.frame.width == 375
        })
        
        secondLine <- [
            Top(5.0).to(goalTextLabel),
            Left(20.0),
            Right(20.0),
            Height(1.0)
            ].when({ () -> Bool in
                return self.view.frame.width == 375 || self.view.frame.width == 320
            })
        
        goalNumberLabel <- [
            Top(30).to(circleProgressView),
            Left(95).to(circleProgressView)
            ].when({ () -> Bool in
                return self.view.frame.width == 375
            })
        
        shareTextLabel <- [
            Top(25).to(secondLine),
            Left(20.0)
            ].when({ () -> Bool in
                return self.view.frame.width == 375 || self.view.frame.width == 320
            })
        
        
        thirdLine <- [
            Top(5.0).to(shareTextLabel),
            Left(20.0),
            Right(20.0),
            Height(1.0)
            ].when({ () -> Bool in
                return self.view.frame.width == 375 || self.view.frame.width == 320
            })
        
        facebookLogoButton <- [
            Top(15).to(thirdLine),
            Left(20.0),
            Height(29),
            Width(29)
            ].when({ () -> Bool in
                return self.view.frame.width == 375 || self.view.frame.width == 320
            })
    
        facebookTextButton <- [
            Top(13).to(thirdLine),
            Left(10).to(facebookLogoButton)
        ].when({ () -> Bool in
                return self.view.frame.width == 375
        })
        
        instagramLogoButton <- [
            Top(15).to(thirdLine),
            Left(95).to(circleProgressView),
            Height(29),
            Width(29)
        ].when({ () -> Bool in
                return self.view.frame.width == 375
        })
        
        instagramTextButton <- [
            Top(13).to(thirdLine),
            Left(10).to(instagramLogoButton)
            ].when({ () -> Bool in
                return self.view.frame.width == 375
        })
        //-----Ending setting for iphone 6,7,8
        
        //-----Starting setting for iphone 5/5s
        userPhoto <- [
            Top(15).to(userNameLabel),
            Left(20),
            Height(85),
            Width(85)
            ].when({ () -> Bool in
                return self.view.frame.width == 320
            })
        
        userStatusLabel <- [
            Top(25).to(userNameLabel),
            Left(12).to(userPhoto)
            ].when({ () -> Bool in
                return self.view.frame.width == 320
            })
        
        totalNumberLabel <- [
            Top(5).to(userStatusLabel),
            Left(12).to(userPhoto)
            ].when({ () -> Bool in
                return self.view.frame.width == 320
            })
        
        userBonusLabel <- [
            Top(5).to(totalNumberLabel),
            Left(12).to(userPhoto)
            ].when({ () -> Bool in
                return self.view.frame.width == 320
            })
        
        circleProgressView <- [
            Height(85),
            Width(85),
            Top(15).to(firstLine),
            Left(20)
            ].when({ () -> Bool in
                return self.view.frame.width == 320
            })
        
        centerImageView <- [
            Height(71),
            Width(71),
            CenterX(0).to(circleProgressView),
            CenterY(0).to(circleProgressView)
            ].when({ () -> Bool in
                return self.view.frame.width == 320
            })

        
        youSavedLabel <- [
            Top(32).to(firstLine),
            Left(65).to(circleProgressView)
            ].when({ () -> Bool in
                return self.view.frame.width == 320
            })
        
        treeImageView <- [
            Top(9).to(youSavedLabel),
            Left(21).to(circleProgressView),
            Height(16.0),
            Width(12.0)
            ].when({ () -> Bool in
                return self.view.frame.width == 320
            })
        
        numberOfTreesLabel <- [
            Top(9).to(youSavedLabel),
            Left(4).to(treeImageView)
            ].when({ () -> Bool in
                return self.view.frame.width == 320
            })
        
        dropWaterImage <- [
            Top(9).to(youSavedLabel),
            Left(12).to(numberOfTreesLabel),
            Height(16.0),
            Width(12.0)
            ].when({ () -> Bool in
                return self.view.frame.width == 320
            })
        
        numberOfWaterLabel <- [
            Top(9).to(youSavedLabel),
            Left(4).to(dropWaterImage)
            ].when({ () -> Bool in
                return self.view.frame.width == 320
            })
        
        lampImageView <- [
            Top(9).to(youSavedLabel),
            Left(12).to(numberOfWaterLabel),
            Height(16.0),
            Width(11)
            ].when({ () -> Bool in
                return self.view.frame.width == 320
            })
        
        numberOfElectroLabel <- [
            Top(9).to(youSavedLabel),
            Left(4.0).to(lampImageView)
            ].when({ () -> Bool in
                return self.view.frame.width == 320
            })
        
        goalTextLabel <- [
            Top(25).to(circleProgressView),
            Left(20),
            Width(125)
            ].when({ () -> Bool in
                return self.view.frame.width == 320
            })
        
        goalNumberLabel <- [
            Top(30).to(circleProgressView),
            Left(87).to(circleProgressView)
            ].when({ () -> Bool in
                return self.view.frame.width == 320
            })
    
        
        facebookTextButton <- [
            Top(15).to(thirdLine),
            Left(10).to(facebookLogoButton)
            ].when({ () -> Bool in
                return self.view.frame.width == 320
            })
        
        instagramLogoButton <- [
            Top(15).to(thirdLine),
            Left(87).to(circleProgressView),
            Height(29),
            Width(29)
            ].when({ () -> Bool in
                return self.view.frame.width == 320
            })
        
        instagramTextButton <- [
            Top(15).to(thirdLine),
            Left(10).to(instagramLogoButton)
            ].when({ () -> Bool in
                return self.view.frame.width == 320
            })
        
        //-----Ending setting for iphone 5,5s
        
        //-----Starting setting for iphone 7+, 6+,
        
        settingsButton <- [
            Top(45),
            Right(25),
            Height(30),
            Width(30)
            ].when({ () -> Bool in
                return self.view.frame.width == 414
            })
        
        userNameLabel <- [
            Top(47),
            CenterX(0).to(view)
            ].when({ () -> Bool in
                return self.view.frame.width == 414
            })
        
        userPhoto <- [
            Top(20).to(userNameLabel),
            Left(20),
            Height(111),
            Width(110)
            ].when({ () -> Bool in
                return self.view.frame.width == 414
            })
        
        userStatusLabel <- [
            Top(41).to(userNameLabel),
            Left(25).to(userPhoto)
            ].when({ () -> Bool in
                return self.view.frame.width == 414
            })
        
        totalNumberLabel <- [
            Top(5).to(userStatusLabel),
            Left(25).to(userPhoto)
            ].when({ () -> Bool in
                return self.view.frame.width == 414
            })
        
        userBonusLabel <- [
            Top(5).to(totalNumberLabel),
            Left(25).to(userPhoto)
            ].when({ () -> Bool in
                return self.view.frame.width == 414
            })
        
        yourStatisticLabel <- [
            Top(35).to(userPhoto),
            Left(25)
            ].when({ () -> Bool in
                return self.view.frame.width == 414
            })
        
        firstLine <- [
            Top(5.0).to(yourStatisticLabel),
            Left(25),
            Right(25),
            Height(1.0)
            ].when({ () -> Bool in
                return self.view.frame.width == 414
            })
        
        circleProgressView <- [
            Height(111),
            Width(110),
            Top(15).to(firstLine),
            Left(25)
            ].when({ () -> Bool in
                return self.view.frame.width == 414
            })
        
        centerImageView <- [
            Height(95),
            Width(95),
            CenterX(0).to(circleProgressView),
            CenterY(0).to(circleProgressView)
            ].when({ () -> Bool in
                return self.view.frame.width == 414
            })
        
        youSavedLabel <- [
            Top(42).to(firstLine),
            Left(94).to(circleProgressView)
            ].when({ () -> Bool in
                return self.view.frame.width == 414
            })
        
        treeImageView <- [
            Top(9).to(youSavedLabel),
            Left(52).to(circleProgressView),
            Height(16.0),
            Width(12.0)
            ].when({ () -> Bool in
                return self.view.frame.width == 414
            })
        
        numberOfTreesLabel <- [
            Top(7).to(youSavedLabel),
            Left(5).to(treeImageView)
            ].when({ () -> Bool in
                return self.view.frame.width == 414
            })
        
        dropWaterImage <- [
            Top(9).to(youSavedLabel),
            Left(10).to(numberOfTreesLabel),
            Height(16.0),
            Width(12.0)
            ].when({ () -> Bool in
                return self.view.frame.width == 414
            })
        
        numberOfWaterLabel <- [
            Top(7).to(youSavedLabel),
            Left(5.0).to(dropWaterImage)
            ].when({ () -> Bool in
                return self.view.frame.width == 414
            })
        
        lampImageView <- [
            Top(9).to(youSavedLabel),
            Left(10).to(numberOfWaterLabel),
            Height(16.0),
            Width(11)
            ].when({ () -> Bool in
                return self.view.frame.width == 414
            })
        
        numberOfElectroLabel <- [
            Top(7).to(youSavedLabel),
            Left(5).to(lampImageView)
            ].when({ () -> Bool in
                return self.view.frame.width == 414
            })
        
        goalTextLabel <- [
            Top(35).to(circleProgressView),
            Left(25),
            Width(150)
            ].when({ () -> Bool in
                return self.view.frame.width == 414
            })
        
        secondLine <- [
            Top(5.0).to(goalTextLabel),
            Left(25),
            Right(25),
            Height(1.0)
            ].when({ () -> Bool in
                return self.view.frame.width == 414
            })
        
        goalNumberLabel <- [
            Top(39).to(circleProgressView),
            Left(119).to(circleProgressView)
            ].when({ () -> Bool in
                return self.view.frame.width == 414
            })
        
        shareTextLabel <- [
            Top(35).to(secondLine),
            Left(25)
            ].when({ () -> Bool in
                return self.view.frame.width == 414
            })
        
        
        thirdLine <- [
            Top(5.0).to(shareTextLabel),
            Left(25),
            Right(25),
            Height(1.0)
            ].when({ () -> Bool in
                return self.view.frame.width == 414
            })
        
        facebookLogoButton <- [
            Top(15).to(thirdLine),
            Left(25),
            Height(29),
            Width(29)
            ].when({ () -> Bool in
                return self.view.frame.width == 414
            })
        
        facebookTextButton <- [
            Top(19).to(thirdLine),
            Left(10).to(facebookLogoButton)
            ].when({ () -> Bool in
                return self.view.frame.width == 414
            })
        
        instagramLogoButton <- [
            Top(15).to(thirdLine),
            Left(119).to(circleProgressView),
            Height(29),
            Width(29)
            ].when({ () -> Bool in
                return self.view.frame.width == 414
            })
        
        instagramTextButton <- [
            Top(19).to(thirdLine),
            Left(10).to(instagramLogoButton)
            ].when({ () -> Bool in
                return self.view.frame.width == 414
            })
        
        
        
    }
}
