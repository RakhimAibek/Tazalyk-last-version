//
//  MapViewController.swift
//  Tazalyk
//
//  Created by Aibek Rakhim on 7/29/17.
//  Copyright © 2017 Next Step. All rights reserved.
//

import UIKit
import EasyPeasy
import Firebase
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    let topSectionView = UIView()
    let mapView = MKMapView()
    let titleLabel = UILabel()
    var locationManager: CLLocationManager!
    
    let cellIdentifier = "myCell"
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        constraintsSetup()
        determineMyCurrentLocation()
        UIApplication.shared.statusBarStyle = .default
        collectionView.register(CategoryCollectionCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
//        Pin.fetch() { result
//            self.pins = result
//        }
        

    }
    
    //MARK: MyCurrentLocation
    func determineMyCurrentLocation() {
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.showsBuildings = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        } else if !CLLocationManager.locationServicesEnabled() {
            locationManager.requestAlwaysAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation:CLLocation = locations[0] as CLLocation
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        mapView.centerCoordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("CLLocation error \(error)")
    }
    
    //MARK: SetupViews
    func setupViews() {
        //topView
        topSectionView.backgroundColor = UIColor(red: 253.0/255.0, green: 253.0/255.0, blue: 254.0/255.0, alpha: 1.0)
        topSectionView.addSubview(titleLabel)

        
        //TitleLabel
        titleLabel.font = UIFont(name: "ProximaNova-Regular", size: 12.0)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = UIColor.black
        titleLabel.text = "Выберите категорию,\nи на карте появится нужный пункт"
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
            cv.dataSource = self
            return cv
        }()
        topSectionView.addSubview(collectionView)
    
        //MapView
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true

        [topSectionView, mapView].forEach {
            view.addSubview($0)
        }
        
    }
    
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
            Top(60),
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

extension MapViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CategoryCollectionCell
        cell.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
}
