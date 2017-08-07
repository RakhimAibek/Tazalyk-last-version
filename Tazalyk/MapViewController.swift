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
    
    // Declaration of UI elements
    let topSectionView = UIView()
    let titleLabel = UILabel()
    let mapView = MKMapView()
    var locationManager: CLLocationManager!
    
    let cellIdentifier = "myCell"
    var collectionView: UICollectionView!

    var categoryArray: [Category] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var pinArray: [[String: AnyObject]] = [[:]]
    
//    var pins = Pin.loadPlaces()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        genData()
        setupViews()
        constraintsSetup()
        determineMyCurrentLocation()
        UIApplication.shared.statusBarStyle = .default
        collectionView.register(CategoryCollectionCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        //Category fetching
        Category.fetch { (result, error) in
            if let res = result {
                self.categoryArray = res
            } else {
                print(error ?? "error")
            }
        }
        
        //TODO: Pin fetching
    }
    
    // Add custom pins in mapView
//    func genData() {
//        for pin in pins {
//            mapView.addAnnotation(pin)
//        }
//    }
    
    //viewFor annotation calls every pin annotation
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        //MARK: Customizing the pins view
        let annotationIdentifier = "AnnotationIdentifier"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.canShowCallout = true
            let pinImage = UIImage(named: "customPin")
            annotationView?.image = pinImage
            annotationView?.calloutOffset = CGPoint(x: -5, y: 5)
            let btn = UIButton(type: .detailDisclosure)
            btn.addTarget(self, action: #selector(infoPressed), for: .touchUpInside)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            annotationView?.annotation = annotation
        }
    
        return annotationView
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if case .authorizedWhenInUse = status {
            locationManager.requestLocation()
        }
    }
    
    func infoPressed() {
    }
    
    //open another ViewController when calloutButtonPressed
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let rankVC = RankingViewController()
            present(rankVC, animated: true, completion: nil)
        }
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
    
    //Succesfully got location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation:CLLocation = locations[0] as CLLocation
        let centerCoordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude)
        mapView.setRegion(MKCoordinateRegionMake(centerCoordinate, MKCoordinateSpanMake(0.1, 0.1)), animated: true)
        locationManager.stopUpdatingLocation()
    }
    
    //Fail with getting location
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("location can’t be determined \(error)")
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

        [topSectionView, mapView].forEach {
            view.addSubview($0)
        }
        
    }
}

//MARK: -Extension UICollectionDelegateAndDataSource
extension MapViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CategoryCollectionCell
        
        cell.backgroundColor = .white
        
        categoryArray.forEach() {_ in
            cell.imageView.image = UIImage(named: categoryArray[indexPath.item].name)
            cell.categoryTitleLabel.text = categoryArray[indexPath.item].name
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    //MARK: CollectioView Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
