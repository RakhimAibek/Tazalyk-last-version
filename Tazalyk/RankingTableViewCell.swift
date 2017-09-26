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
    
    let userNameLabel = UILabel()
    let passedStatisticLabel = UILabel()
    let statusImageView = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureView()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        
        userNameLabel.textColor = .black
        userNameLabel.alpha = 1.0
        userNameLabel.numberOfLines = 0
        userNameLabel.font = UIFont(name: "ProximaNova-Bold", size: 16.0)
        
        passedStatisticLabel.alpha = 1.0
        passedStatisticLabel.numberOfLines = 0
        passedStatisticLabel.font = UIFont(name: "ProximaNova-Semibold", size: 12.0)
        passedStatisticLabel.textColor = UIColor(red: 143.0/255.0, green: 142.0/255.0, blue: 148.0/255.0, alpha: 1.0)
        
        statusImageView.alpha = 1.0
        statusImageView.clipsToBounds = true
        statusImageView.layer.cornerRadius = statusImageView.frame.size.height / 2
        
        [userNameLabel, passedStatisticLabel, statusImageView].forEach {
            self.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        
        userNameLabel <- [
            Top(11.0),
            Left(14.0).to(statusImageView)
        ]
        
        passedStatisticLabel <- [
            Top(4.5).to(userNameLabel),
            Left(14.0).to(statusImageView)
        ]
        
        statusImageView <- [
            Top(7.0),
            Left(32.0),
            Height(46.0),
            Width(46.0)
        ]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)

    }

}
