//
//  MapVC+constraints.swift
//  Tazalyk
//
//  Created by Aibek Rakhim on 8/4/17.
//  Copyright © 2017 Next Step. All rights reserved.
//

import UIKit
import EasyPeasy

extension MapViewController {
    
    //MARK: SetupConstraints
    func constraintsSetup() {
        //topView
        topSectionView <- [
            Top(0.0),
            Left(0.0),
            Right(0.0),
            Height(128.0)
        ]
        
        //TitleLabel
        titleLabel <- [
            Top(30.0),
            CenterX(0.0),
        ]
        
        //CollectionView
        collectionView <- [
            Top(68),
            Left(0.0),
            Right(0.0),
            Bottom(0.0)
        ]
        
        //MapView
        mapView <- [
            Top(0.0).to(topSectionView),
            Left(0.0).to(view),
            Right(0.0).to(view),
            Bottom(0.0).to(view)
        ]
    }
}
