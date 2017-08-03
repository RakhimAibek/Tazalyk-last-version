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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        imageView.backgroundColor = UIColor.black
        self.addSubview(imageView)
    }
    
    private func configureConstraints() {
        imageView <- [
            CenterX(0.0),
            CenterY(0.0),
            Height(40.0),
            Width(40.0)
        ]
    }
    
}
