//
//  CategoryCollectionCell.swift
//  Tazalyk
//
//  Created by Aibek Rakhim on 8/1/17.
//  Copyright © 2017 Next Step. All rights reserved.
//

import UIKit
import EasyPeasy

class CategoryCollectionCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    let categoryTitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        imageView.contentMode = .scaleAspectFill
        categoryTitleLabel.textColor = .black
        categoryTitleLabel.font = UIFont(name: "ProximaNova-Regular", size: 9.0)
        
        [imageView, categoryTitleLabel].forEach() {
            self.addSubview($0)
        }
    }
    
    private func configureConstraints() {
        imageView <- [
            Top(10.0),
            CenterX(0.0),
            Height(40.0),
            Width(40.0),
        ]
        
        categoryTitleLabel <- [
            CenterX(0.0),
            Top(2.0).to(imageView),
        ]
    }
    
}
