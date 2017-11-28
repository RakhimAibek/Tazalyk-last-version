//
//  ProfileViewController.swift
//  Tazalyk
//
//  Created by Aibek Rakhim on 8/3/17.
//  Copyright © 2017 Next Step. All rights reserved.
//

import UIKit
import Social
import EasyPeasy
import SVProgressHUD
import FirebaseAuth
import FirebaseDatabase
import CircleProgressView

class ProfileViewController: UIViewController {
    
    let settingsButton = UIButton()
    
    let userNameLabel = UILabel()
    let userStatusLabel = UILabel()
    let userBonusLabel = UILabel()
    
    let yourStatisticLabel = UILabel()
    let firstLine = UIView()
    let youSavedLabel = UILabel()
    
    let totalNumberLabel = UILabel()
    let circleProgressView = CircleProgressView()
    let infoTextPassed = UILabel()
    
    let treeImageView = UIImageView()
    let numberOfTreesLabel = UILabel()
    
    let dropWaterImage = UIImageView()
    let numberOfWaterLabel = UILabel()
    
    let lampImageView = UIImageView()
    let numberOfElectroLabel = UILabel()
    
    let goalTextLabel = UILabel()
    let goalNumberLabel = UILabel()
    let secondLine = UIView()
    
    let shareTextLabel = UILabel()
    let thirdLine = UIView()
    let facebookLogoButton = UIButton()
    let facebookTextButton = UIButton()
    
    var ref: DatabaseReference?
    var userArray : [User] = []
    var passedArray: [Passed] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureConstraints()
        SVProgressHUD.setDefaultStyle(.light)
        SVProgressHUD.setDefaultAnimationType(.flat)
        SVProgressHUD.setDefaultMaskType(.gradient)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if UserDefaults.standard.object(forKey: "userUID") != nil {
            User.fetch(completion: { (result, error) in
                guard let result = result else {
                    print("error User fetching")
                    return
                }
                self.userArray = result
                self.settingAndFetchingData()
            })
        }
    }
    
    func settingAndFetchingData() {
        
        if let currentUserId = UserDefaults.standard.object(forKey: "userUID") {
            ref = Database.database().reference().child("Users").child(currentUserId as! String)
        }
        
        for i in userArray {
            
            let userBonus = i.bonus ?? 0
            let totalPassed = i.total ?? 0
            var userName = i.userName ?? ""
            var userStatus = ""
            var goalNumber = 0
            
            if userName == "" || userName.characters.count == 0 || userName.characters.count < 2 {
                
            let alert = UIAlertController(title: "Как вас зовут?", message: "Ваше имя будет отображено в рейтинге", preferredStyle: .alert)
                
            alert.addTextField { (textField: UITextField) in
                textField.keyboardAppearance = .default
                textField.keyboardType = .default
                textField.autocorrectionType = .default
                textField.placeholder = "Введите свое имя"
                textField.clearButtonMode = .whileEditing
            }
                
            let submitAction = UIAlertAction(title: "Подтвердить", style: .default, handler: { [weak self] (action) -> Void in
                
                // Get 1st TextField's text
                let textField = alert.textFields![0]
                userName = textField.text!
                print(userName)
                self?.ref?.child("userName").setValue(userName)
            })
                
            let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
                
            alert.addAction(submitAction)
            alert.addAction(cancelAction)
                
            self.present(alert, animated: false, completion: nil)
                
            }
            

        switch totalPassed {
        case 0...50:
            userStatus = "Неравнодушный"
        case 51...100:
            userStatus = "Вовлеченный"
        case 101...200:
            userStatus = "Заботливый"
        case 201...500:
            userStatus = "Эко-Герой"
        default:
            userStatus = "Эко-Супергерой"
        }
        
        //Setuping circleProgressView
        var circleProgressValue = 0.0

        if userStatus == "Неравнодушный" {

            goalNumber = 51 - totalPassed
            circleProgressValue = (Double((totalPassed * 100) / 50)) / 100

        } else if userStatus == "Вовлеченный" {

            goalNumber = 101 - totalPassed
            circleProgressValue = (Double((totalPassed * 100) / 150)) / 100

        } else if userStatus == "Заботливый" {

            goalNumber = 201 - totalPassed
            circleProgressValue = (Double((totalPassed * 100) / 300)) / 100

        } else if userStatus == "Эко-Герой" {

            goalNumber = 501 - totalPassed
            circleProgressValue = (Double((totalPassed * 100) / 1000)) / 100
        } else {
            goalNumber = 5000 - totalPassed
            circleProgressValue = (Double((totalPassed * 100) / 5000)) / 100
        }
        
        circleProgressView.setProgress(circleProgressValue, animated: true)
        
        //What did you save? Compute from totalPassed
        let savedTreeNumber = (totalPassed * 1) / 60
        let savedWaterNumber = (totalPassed * 1200) / 60
        let savedElectroNumber = (totalPassed * 60) / 60
        
        numberOfTreesLabel.text = "\(savedTreeNumber)"
        numberOfElectroLabel.text = "\(savedElectroNumber) квт"
        
        //Formatter to short write
        if totalPassed > 999 {
            self.totalNumberLabel.text = "\(totalPassed / 1000)т \(totalPassed % 1000) кг"
        } else if totalPassed < 1000 {
            self.totalNumberLabel.text = "\(totalPassed) кг"
        }
        
        if savedWaterNumber > 999 {
            numberOfWaterLabel.text = "\(savedWaterNumber / 1000)м³ \(savedWaterNumber % 1000) л"
        } else if savedWaterNumber < 1000 {
            numberOfWaterLabel.text = "\(savedWaterNumber) л"
        }
        
        self.userNameLabel.text = userName
        self.userBonusLabel.text = "Бонусы: \(userBonus)"
        self.userStatusLabel.text = "Статус: \(userStatus)"
        self.goalNumberLabel.text = "\(goalNumber) кг"
        
        //Saving savedData in FireBase DataBase
        self.ref?.child("total").setValue(totalPassed)

        }
    }
    
    //Share setuping
    func facebookBTNpressed(sender: UIButton) {
        SVProgressHUD.show()
        if let shareVC = SLComposeViewController(forServiceType: SLServiceTypeFacebook) {
            shareVC.setInitialText("#TazalykApp")
            
            shareVC.add(URL(string: "https://tazalyk.app.link/jcNZSJyHRF"))
            present(shareVC, animated: true)
        }
        SVProgressHUD.dismiss(withDelay: 0.5)
        
    }

    func settingsButtonPressed(sender: UIButton) {
        let settingsNavigationController = UINavigationController(rootViewController: SettingsViewController())
        settingsNavigationController.view.backgroundColor = UIColor.white
        settingsNavigationController.tabBarItem.image = UIImage(named: "profileIbar")
        settingsNavigationController.tabBarItem.selectedImage = UIImage(named: "profileIbarSelected")?.withRenderingMode(.alwaysOriginal)
        
        present(settingsNavigationController, animated: true, completion: nil)
        
    }
}
