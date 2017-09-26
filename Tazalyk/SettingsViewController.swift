//
//  SettingsViewController.swift
//  Tazalyk
//
//  Created by Aibek Rakhim on 8/18/17.
//  Copyright © 2017 Next Step. All rights reserved.
//

import UIKit
import EasyPeasy
import FirebaseAuth
import SVProgressHUD

class SettingsViewController: UIViewController {
    
    let textDescriptionLabel = UILabel()
    let textRateLabel = UILabel()
    let rateButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureConstraints()
    }
    
    func configureView() {
        //NavigationBar configure View
        if UserDefaults.standard.object(forKey: "userUID") != nil {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "signOutButton"), style: .plain, target: self, action: #selector(logOutButtonPressed(sender:)))
        }
        
        navigationItem.title = "Настройки"
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "ProximaNova-Bold", size: 18.0)!, NSForegroundColorAttributeName: UIColor(red: 86.0/255.0, green: 86.0/255.0, blue: 86.0/255.0, alpha: 1.0)]
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.tintColor = UIColor(red: 86.0/255.0, green: 86.0/255.0, blue: 86.0/255.0, alpha: 1.0)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "backButton"), style: .plain, target: self, action: #selector(backButtonPressed(sender:)))
        
        //Custing only one word
        let myText = "Tazalyk - сдавая мусор в пункты приема, зарабатывайте деньги и бонусы"
        let myFont = UIFont(name: "ProximaNova-Regular", size: 16.0)
        
        let myAttr = [
            NSFontAttributeName: myFont!,
            NSForegroundColorAttributeName: UIColor.black
        ]
        
        let myMutableString = NSMutableAttributedString(string: myText, attributes: myAttr)
        myMutableString.addAttribute(NSFontAttributeName, value: UIFont(name: "ProximaNova-Bold", size: 16.0)!, range: NSRange(location: 0, length: 7))
        print(myMutableString)
        
        textDescriptionLabel.attributedText = myMutableString
        textDescriptionLabel.numberOfLines = 3
        textDescriptionLabel.textAlignment = .center
        
        //Rate button
        rateButton.setTitle("Оценить", for: .normal)
        rateButton.setTitleColor(.white, for: .normal)
        rateButton.setTitleColor(UIColor(red: 219.0/255, green: 219.0/255, blue: 219.0/255, alpha: 0.7), for: .highlighted)
        rateButton.addTarget(self, action: #selector(rateButtonPressed(sender:)), for: .touchUpInside)
        rateButton.titleLabel?.font = UIFont(name: "ProximaNova-Bold", size: 16.0)
        rateButton.backgroundColor = UIColor(red: 109.0/255.0, green: 168.0/255.0, blue: 207.0/255.0, alpha: 1.0)
        rateButton.layer.cornerRadius = 7.0
        
        //TextRate UILabel
        textRateLabel.text = "Заранее спасибо за 5 звезд :)"
        textRateLabel.font = UIFont(name: "ProximaNova-Regular", size: 14.0)
        textRateLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        textRateLabel.textAlignment = .center
        
        [textDescriptionLabel, rateButton, textRateLabel].forEach {
            self.view.addSubview($0)
        }
        
    }
    
    func rateButtonPressed(sender: UIButton) {
        let appDelegate = AppDelegate()
        appDelegate.requestReview()
    }
    
    func configureConstraints() {
        textDescriptionLabel <- [
            Top(150.0),
            CenterX(0.0),
            Left(30.0),
            Right(30.0)
        ]
        
        textRateLabel <- [
            CenterX(0.0),
            Top(55.0).to(textDescriptionLabel),
            Left(30.0),
            Right(30.0)
        ]
  
        rateButton <- [
            CenterX(0.0),
            Top(15.0).to(textRateLabel),
            Left(30.0),
            Right(30.0),
            Height(48.0)
        ]
    }
    
    func backButtonPressed(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func logOutButtonPressed(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Вы хотите выйти из своего профиля?", message: "Ваш профиль не будет доступен", preferredStyle: .alert)
        let action = UIAlertAction(title: "Да", style: .default, handler: { [weak self] (UIAlertAction) in

            do {
                try Auth.auth().signOut()

                if Auth.auth().currentUser == nil {
                    UserDefaults.standard.removeObject(forKey: "userUID")
                    UserDefaults.standard.synchronize()

                    let firstVC = FirstViewController()
                    self?.present(firstVC, animated: true, completion: nil)
                }
            } catch let signOutError as NSError {
                print(signOutError.localizedDescription)
            }
        })

        let cancel = UIAlertAction(title: "Нет", style: .default, handler: nil)

        alert.addAction(action)
        alert.addAction(cancel)
        
        self.present(alert, animated: false, completion: nil)
    }
}

