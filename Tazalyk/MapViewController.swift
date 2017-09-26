//
//  MapViewController.swift
//  Tazalyk
//
//  Created by Aibek Rakhim on 7/29/17.
//  Copyright © 2017 Next Step. All rights reserved.

import UIKit
import EasyPeasy
import Firebase
import MapKit
import CoreLocation
import SVProgressHUD

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    // Declaration of UI elements
    let topSectionView = UIView()
    let titleLabel = UILabel()
    let mapView = MKMapView()
    var locationManager: CLLocationManager!
    
    let cellIdentifier = "myCell"
    var collectionView: UICollectionView!
    
    //ZoomIn and ZoomOut Button, find myLocation
    let zoomInButton = UIButton()
    let zoomOutButton = UIButton()
    let findMyLocationButton = UIButton()

    var selectedIndexItem = Int()
    var selectedIndexPath:Int?
    var categoryArray: [Category] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var pinArray = [Pin]()
    var filteredArrayOfPin = [Pin]()
    var valueCategory = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = .default
    
        
        SVProgressHUD.setDefaultStyle(.light)
        SVProgressHUD.setDefaultAnimationType(.flat)
        SVProgressHUD.setDefaultMaskType(.gradient)
        SVProgressHUD.show(withStatus: "Загрузка карты..")
        determineMyCurrentLocation()
        
        //Category fetching
        Category.fetch { (result, error) in
            if let res = result {
                self.categoryArray = res
            } else {
                print(error ?? "error category fetching")
            }
        }
        
        Pin.fetch { pins, error in
            guard let pins = pins else {
                print(error ?? "error pin fetching")
                return
            }
            
            self.pinArray = pins
            self.mapView.addAnnotations(self.pinArray)
        }
        
        setupViews()
        constraintsSetup()
        
        //Setting CollectionView
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CategoryCollectionCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        SVProgressHUD.dismiss(withDelay: 1.5)
        
    }
    
    //viewFor annotation calls every pin annotation
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        if annotation is MKUserLocation {
            return nil
        }
        let ant = annotation as? Pin
        //MARK: Customizing the pins view
        let annotationIdentifier = "AnnotationIdentifier"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.canShowCallout = true

            if ant?.sales == "yes" {
                annotationView?.image = UIImage(named: "yes")
            } else {
                annotationView?.image = UIImage(named: "no")
            }
            annotationView?.calloutOffset = CGPoint(x: -5, y: 5)
            let btn = UIButton(type: .detailDisclosure)
            btn.addTarget(self, action: #selector(infoPressed), for: .touchUpInside)
            annotationView?.rightCalloutAccessoryView = btn
            
        } else {
            if ant?.sales == "yes" {
                annotationView?.image = UIImage(named: "yes")
            } else {
                annotationView?.image = UIImage(named: "no")
            }
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
            let detailedVC = DetailedPinViewController()
            detailedVC.selectedPinVar = pinArray[selectedIndexPath ?? 0]
            let detailedNavigationVC = UINavigationController(rootViewController: detailedVC)
            present(detailedNavigationVC, animated: true, completion: nil)
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
}


//MARK: Extension UICollectionDelegateAndDataSource
extension MapViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    //MARK: DataSource of collectionView
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CategoryCollectionCell
        cell.backgroundColor = .white
  
        categoryArray.forEach() {_ in
            cell.imageView.image = UIImage(named: categoryArray[indexPath.item].name!)
            cell.categoryTitleLabel.text = categoryArray[indexPath.item].name
        }

        return cell
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        let coordinate: CLLocationCoordinate2D = (view.annotation?.coordinate)!
        
        for (index, element) in pinArray.enumerated() {
            if element.coordinate.isEqual(coordinate) {
                selectedIndexPath = index
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    //MARK: Delegate to Select item
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        let selectedCell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionCell
        selectedIndexItem = indexPath.item
        
        if selectedIndexItem == indexPath.item {
            selectedCell?.backgroundColor = UIColor(red: 208.0/255.0, green: 220.0/255.0, blue: 241.0/255.0, alpha: 1.0)
            selectedCell?.imageView.image = UIImage(named: categoryArray[indexPath.item].name!+"1")
            valueCategory = (selectedCell?.categoryTitleLabel.text)!
        }
        
        let filtered = pinArray.filter {
            let categories = $0.category?.name?.components(separatedBy: ",")
            return (categories?.contains(self.valueCategory))!
        }
        

        self.filteredArrayOfPin = filtered
        self.mapView.removeAnnotations(mapView.annotations)
        self.mapView.addAnnotations(self.valueCategory.isEmpty ? pinArray : filteredArrayOfPin)
    
    }
    
    //MARK: Delegate to didSelect item
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        let selectedCell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionCell
    
        selectedCell?.imageView.image = UIImage(named: categoryArray[indexPath.item].name!)
        selectedCell?.backgroundColor = UIColor.white
        
        collectionView.reloadItems(at: [indexPath])
    }
    
    //ZoomInButton pressed
    func zoomInButtonPressed(sender: UIButton) {
        mapView.setZoomByDelta(delta: 0.5, animated: true)
    }
    
    //ZoomOutButton pressed
    func zoomOutButtonPressed(sender: UIButton) {
        mapView.setZoomByDelta(delta: 2, animated: true)
    }
    
    //FindMylocationBTN pressed
    func findMyLocationBTNpressed(sender: UIButton) {
        locationManager.startUpdatingLocation()
    }
}

extension CLLocationCoordinate2D {
    func isEqual(_ coord: CLLocationCoordinate2D) -> Bool {
        return (fabs(self.latitude - coord.latitude) < .ulpOfOne) && (fabs(self.longitude - coord.longitude) < .ulpOfOne)
    }
}

extension MKMapView {
    
    // delta is the zoom factor
    // 2 will zoom out x2
    // .5 will zoom in by x2
    
    func setZoomByDelta(delta: Double, animated: Bool) {
        var _region = region;
        var _span = region.span;
        _span.latitudeDelta *= delta;
        _span.longitudeDelta *= delta;
        _region.span = _span;
        
        setRegion(_region, animated: animated)
    }
}
