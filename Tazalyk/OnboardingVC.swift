//
//  OnboardingViewController.swift
//  Tazalyk
//
//  Created by Aibek Rakhim on 10/5/17.
//  Copyright © 2017 Next Step. All rights reserved.
//

import UIKit
import EasyPeasy

class OnboardingVC: UIViewController{
    
    var onboardCollectionView: UICollectionView!
    var pageControl: UIPageControl!
    var startButton = UIButton()
    
    let cellID = "myCell"
    
    let pagesInfo = PageOnboard.pageInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        setupView()
        configureCons()
        onboardCollectionView.register(OnboardingCollectionCell.self, forCellWithReuseIdentifier: cellID)
    }
    
    func setupView() {
        
        onboardCollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height + 20)
            let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
            cv.backgroundColor = .white
            cv.dataSource = self
            cv.delegate = self
            cv.isPagingEnabled = true
            return cv
        }()
        
        pageControl = {
            let pc = UIPageControl()
            pc.currentPageIndicatorTintColor = UIColor(red: 21/255.0, green: 180/225.0, blue: 241/255.0, alpha: 1)
            pc.pageIndicatorTintColor = UIColor(red: 21/255.0, green: 180/225.0, blue: 241/255.0, alpha: 0.2)
            pc.numberOfPages = pagesInfo.count
            return pc
        }()
        
        startButton = {
            let sb = UIButton()
            sb.setTitle("Стать Эко-Супергероем", for: .normal)
            sb.setTitleColor(UIColor.white, for: .normal)
            sb.titleLabel?.font = UIFont(name: "ProximaNova-Bold", size: 22)
            sb.setTitleColor(UIColor(red: 219.0/255, green: 219.0/255, blue: 219.0/255, alpha: 0.7), for: .highlighted)
            sb.backgroundColor = UIColor(red: 21.0/255.0, green: 180.0/255.0, blue: 241.0/255.0, alpha: 1)
            sb.addTarget(self, action: #selector(startBTNpressed(sender:)), for: .touchUpInside)
            return sb
        }()
        
        [onboardCollectionView, pageControl, startButton].forEach {
            self.view.addSubview($0)
        }
    }
    
    //when startButton pressed
    func startBTNpressed(sender: UIButton) {
        let onboardingDefaults = UserDefaults.standard
        onboardingDefaults.set(1, forKey: "onboardingDefaults")
        let loginVC = LoginViewController()
        present(loginVC, animated: true, completion: nil)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        //To indicate current page
        let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
        pageControl.currentPage = pageNumber
        
        if pageNumber == pagesInfo.count - 1 {
            
            pageControl <- [
                Bottom(-50)
            ]
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
            
            startButton <- [
                Bottom(0)
            ]
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
            
        } else {
            pageControl <- [
                Bottom(50).when({ () -> Bool in
                    return self.view.frame.width > 320 && self.view.frame.width < 414 // 375 - iphone 8
                }),
                Bottom(35).when({ () -> Bool in
                    return self.view.frame.width <= 320 // 320 - iphone 5s
                }),
                Bottom(100).when({ () -> Bool in
                    return self.view.frame.width >= 414 && self.view.frame.width > 375
                })
            ]
            startButton <- [
                Bottom(-100)
            ]
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    func configureCons() {
        onboardCollectionView <- [
            Top(0).to(view),
            Left(0).to(view),
            Right(0).to(view),
            Bottom(0).to(view)
        ]
        pageControl <- [
            CenterX(0),
            Bottom(50).when({ () -> Bool in
                return self.view.frame.width > 320 && self.view.frame.width < 414 // 375 - iphone 8
            }),
            Bottom(35).when({ () -> Bool in
                return self.view.frame.width <= 320 // 320 - iphone 5s
            }),
            Bottom(100).when({ () -> Bool in
                return self.view.frame.width >= 414 && self.view.frame.width > 375 // 414 - iphone 8+
            }),
            Width(30),
            Height(30)
        ]
        
        startButton <- [
            Bottom(-100),
            Left(0),
            Right(0),
            Height(50)
        ]
    }
}

extension OnboardingVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pagesInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! OnboardingCollectionCell
        
        let page = pagesInfo[indexPath.item]
        cell.page = page
        return cell
    }
    

}
