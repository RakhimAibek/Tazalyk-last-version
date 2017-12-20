//
//  RankingTableViewCell.swift
//  Tazalyk
//
//  Created by Aibek Rakhim on 8/23/17.
//  Copyright © 2017 Next Step. All rights reserved.
//

import UIKit
import EasyPeasy

class RankingTableViewCell: UITableViewCell {
    
    let numerationsUser = UILabel()
    let userNameLabel = UILabel()
    let passedStatisticLabel = UILabel()
    let statusImageView = UIImageView()
    let amountOfpassed = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureView()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        print("reuse")
        statusImageView.image = UIImage(named: "defaultUserPhoto")
        backgroundColor = UIColor.white
    }
    
    private func configureView() {
        numerationsUser.text = ""
        numerationsUser.textColor = .black
        numerationsUser.font = UIFont(name: "ProximaNova-Bold", size: 16)
    
        userNameLabel.textColor = .black
        userNameLabel.numberOfLines = 2
        userNameLabel.font = UIFont(name: "ProximaNova-Semibold", size: 16.0)
        
        passedStatisticLabel.numberOfLines = 0
        passedStatisticLabel.font = UIFont(name: "ProximaNova-Semibold", size: 12.0)
        passedStatisticLabel.textColor = UIColor(red: 85/255.0, green: 84/255.0, blue: 84/255.0, alpha: 1.0)
        
        amountOfpassed.textColor = .black
        amountOfpassed.textAlignment = .right
        amountOfpassed.font = UIFont(name: "ProximaNova-Bold", size: 16)
        
        
        statusImageView.image = UIImage(named: "defaultUserPhoto")
        statusImageView.contentMode = .scaleAspectFill
        statusImageView.clipsToBounds = true
        statusImageView.layer.cornerRadius = 24.5
        
        [numerationsUser, userNameLabel, passedStatisticLabel, statusImageView, amountOfpassed].forEach {
            self.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        
        numerationsUser <- [
            Left(16),
            Top(25),
            Bottom(25)
        ]
        
        statusImageView <- [
            Top(11),
            Left(6).to(numerationsUser),
            Height(49),
            Width(49)
        ]
        
        userNameLabel <- [
            Top(16),
            Left(9).to(statusImageView),
            Width(170)
        ]

        passedStatisticLabel <- [
            Top(0).to(userNameLabel),
            Left(9).to(statusImageView)
        ]
        
        amountOfpassed <- [
            Right(28),
            Top(25),
            Bottom(25)
        ]
 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)

    }

}
