//
//  OnboardingCollectionCell.swift
//  Tazalyk
//
//  Created by Aibek Rakhim on 10/5/17.
//  Copyright © 2017 Next Step. All rights reserved.
//

import UIKit
import EasyPeasy

class OnboardingCollectionCell: UICollectionViewCell {
    
    var page: PageOnboard? {
        didSet {
            guard let page = page else { return }
            onboardImage.image = UIImage(named: page.imageName)            
            bigLabel.text = page.title
            explainLabel.text = page.message
        }
    }
    
    let bigLabel = UILabel()
    let explainLabel = UILabel()
    let onboardImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        print(self.frame.width,"is my frame size")
        self.backgroundColor = UIColor.white
        //Big label settings
        bigLabel.numberOfLines = 0
        bigLabel.textAlignment = .center
        bigLabel.font = UIFont(name: "ProximaNova-Bold", size: 30.0)
        bigLabel.adjustsFontSizeToFitWidth = true
        bigLabel.textColor = UIColor(red: 95.0/255.0, green: 95.0/255.0, blue: 95.0/255.0, alpha: 1.0)
        
        // Introducing image
        onboardImage.contentMode = .scaleAspectFill
        
        //Explain label
        explainLabel.numberOfLines = 0
        explainLabel.textAlignment = .center
        explainLabel.font = UIFont(name: "ProximaNova-Semibold", size: 17.0)
        explainLabel.adjustsFontSizeToFitWidth = false
        explainLabel.textColor = UIColor(red: 65.0/255.0, green: 65.0/255.0, blue: 65.0/255.0, alpha: 1.0)
        
        [bigLabel, onboardImage, explainLabel].forEach {
            self.addSubview($0)
        }
    }
    
    private func configureConstraints() {
        bigLabel <- [
            //setuping for frame - 320
            Top(65).when({ () -> Bool in
                return self.frame.width <= 320
            }),
            Left(20).when({ () -> Bool in
                return self.frame.width <= 320
            }),
            Right(20).when({ () -> Bool in
                return self.frame.width <= 320
            }),
            Height(66).when({ () -> Bool in
                return self.frame.width <= 320
            }),
            
            //setuping for frame - 375
            Top(65).when({ () -> Bool in
                return self.frame.width > 320 && self.frame.width < 414
            }),
            Left(20).when({ () -> Bool in
                return self.frame.width > 320 && self.frame.width < 414
            }),
            Right(20).when({ () -> Bool in
                return self.frame.width > 320 && self.frame.width < 414
            }),
            Height(66).when({ () -> Bool in
                return self.frame.width > 320 && self.frame.width < 414
            }),
            
            //setuping for frame - 414
            Top(75).when({ () -> Bool in
                return self.frame.width >= 414 && self.frame.width > 375
            }),
            Left(10).when({ () -> Bool in
                return self.frame.width >= 414 && self.frame.width > 375
            }),
            Right(10).when({ () -> Bool in
                return self.frame.width >= 414 && self.frame.width > 375
            }),
            Height(100).when({ () -> Bool in
                return self.frame.width >= 414 && self.frame.width > 375
            })
            ]
        
        onboardImage <- [
            
            //setuping for frame - 320
            Top(25).to(bigLabel).when({ () -> Bool in
                return self.frame.width <= 320
            }),
            Width(319).when({ () -> Bool in
                return self.frame.width <= 320
            }),
            Height(217).when({ () -> Bool in
                return self.frame.width <= 320
            }),
            CenterX(0).when({ () -> Bool in
                return self.frame.width <= 320
            }),
            
            //setuping for frame - 375
            Top(25).to(bigLabel).when({ () -> Bool in
                return self.frame.width > 320 && self.frame.width < 414
            }),
            Width(319).when({ () -> Bool in
                return self.frame.width > 320 && self.frame.width < 414
            }),
            Height(217).when({ () -> Bool in
                return self.frame.width > 320 && self.frame.width < 414
            }),
            CenterX(0).when({ () -> Bool in
                return self.frame.width > 320 && self.frame.width < 414
            }),
            
            //setuping for frame - 414
            Top(25).to(bigLabel).when({ () -> Bool in
                return self.frame.width >= 414 && self.frame.width > 375
            }),
            Width(319).when({ () -> Bool in
                return self.frame.width >= 414 && self.frame.width > 375
            }),
            Height(217).when({ () -> Bool in
                return self.frame.width >= 414 && self.frame.width > 375
            }),
            CenterX(0).when({ () -> Bool in
                return self.frame.width >= 414 && self.frame.width > 375
            })
            ]
        
        explainLabel <- [
            //setuping for frame - 320
            Top(20).to(onboardImage).when({ () -> Bool in
                return self.frame.width <= 320
            }),
            Left(20).when({ () -> Bool in
                return self.frame.width <= 320
            }),
            Right(20).when({ () -> Bool in
                return self.frame.width <= 320
            }),
            
            //setuping for frame - 375
            Top(20).to(onboardImage).when({ () -> Bool in
                return self.frame.width > 320 && self.frame.width < 414
            }),
            Left(20).when({ () -> Bool in
                return self.frame.width > 320 && self.frame.width < 414
            }),
            Right(20).when({ () -> Bool in
                return self.frame.width > 320 && self.frame.width < 414
            }),
            
            //setuping for frame - 414
            Top(20).to(onboardImage).when({ () -> Bool in
                return self.frame.width >= 414 && self.frame.width > 375
            }),
            Left(20).when({ () -> Bool in
                return self.frame.width >= 414 && self.frame.width > 375
            }),
            Right(20).when({ () -> Bool in
                return self.frame.width >= 414 && self.frame.width > 375
            })
            ]
    }
    
}
