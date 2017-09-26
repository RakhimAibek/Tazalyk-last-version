//
//  MapVC+constraints.swift
//  Tazalyk
//
//  Created by Aibek Rakhim on 8/4/17.
//  Copyright © 2017 Next Step. All rights reserved.

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
            Height(135.0)
        ]
        
        //TitleLabel
        titleLabel <- [
            Top(30.0),
            CenterX(0.0)
        ]
        
        //CollectionView
        collectionView <- [
            Top(4.0).to(titleLabel),
            Left(0.0),
            Right(0.0),
            Height(67)
        ]
        
        //MapView
        mapView <- [
            Top(0.0).to(topSectionView),
            Left(0.0).to(view),
            Right(0.0).to(view),
            Bottom(0.0).to(view)
        ]
        
        zoomInButton <- [
            Top(85.0).to(topSectionView),
            Right(15.0),
            Height(50.0),
            Width(50.0)
        ]
        
        zoomOutButton <- [
            CenterY(45).to(zoomInButton),
            CenterX().to(zoomInButton),
            Height(35.0),
            Width(35.0)
        ]
        
        findMyLocationButton <- [
            CenterY(65).to(zoomOutButton),
            CenterX().to(zoomOutButton),
            Height(45.0),
            Width(45.0)
        ]
    }
    
    //MARK: SetupViews
    func setupViews() {
        //topView
        topSectionView.backgroundColor = UIColor(red: 253.0/255.0, green: 253.0/255.0, blue: 254.0/255.0, alpha: 1.0)
        topSectionView.addSubview(titleLabel)
        
        //TitleLabel
        titleLabel.font = UIFont(name: "ProximaNova-Semibold", size: 14.0)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = UIColor.black
        titleLabel.text = "Выберите категорию,\nи на карте появятся нужные пункты"
        titleLabel.textAlignment = .center
        
        //CollectionView
        collectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            let size = (self.view.frame.width - 1) / 5
            layout.itemSize = CGSize(width: size, height: size)
            layout.minimumLineSpacing = 1.5
            let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
            cv.backgroundColor = UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1.0)
            cv.layer.borderColor = UIColor.lightGray.cgColor
            cv.layer.borderWidth = 0.4
            cv.dataSource = self
            return cv
        }()
        topSectionView.addSubview(collectionView)
        
        //MapView
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        //ZoomIn button
        zoomInButton.setImage(UIImage(named: "zoomInButton"), for: .normal)
        zoomInButton.layer.cornerRadius = 25
        zoomInButton.clipsToBounds = true
        zoomInButton.addTarget(self, action: #selector(zoomInButtonPressed(sender:)), for: .touchUpInside)
        
        //ZoomOut button
        zoomOutButton.setImage(UIImage(named: "zoomOutButton"), for: .normal)
        zoomOutButton.layer.cornerRadius = 17.5
        zoomOutButton.clipsToBounds = true
        zoomOutButton.addTarget(self, action: #selector(zoomOutButtonPressed(sender:)), for: .touchUpInside)
        
        //findMyLocation Button
        findMyLocationButton.setImage(UIImage(named: "findMyLocationButton"), for: .normal)
        findMyLocationButton.layer.cornerRadius = 22.5
        findMyLocationButton.clipsToBounds = true
        findMyLocationButton.addTarget(self, action: #selector(findMyLocationBTNpressed(sender:)), for: .touchUpInside)
        
        [topSectionView, mapView, zoomInButton, zoomOutButton, findMyLocationButton].forEach {
            view.addSubview($0)
        }
        
    }
}
