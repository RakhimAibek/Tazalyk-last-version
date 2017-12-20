//
//  ProfileViewController.swift
//  Tazalyk
//
//  Created by Aibek Rakhim on 8/3/17.
//  Copyright © 2017 Next Step. All rights reserved.
//

import UIKit
import Social
import Fusuma
import EasyPeasy
import SVProgressHUD
import SCLAlertView
import Firebase
import FirebaseAuth
import FirebaseDatabase
import CircleProgressView

class ProfileViewController: UIViewController, FusumaDelegate {

    let settingsButton = UIButton()
    
    let userNameLabel = UILabel()
    let userStatusLabel = UILabel()
    let userBonusLabel = UILabel()
    
    let storageRef = Storage.storage().reference()
    var imageLink: String!
    let avatarTap = UITapGestureRecognizer()
    var userPhoto = UIImageView()
    
    let yourStatisticLabel = UILabel()
    let firstLine = UIView()
    let youSavedLabel = UILabel()
    
    var checkImageLoad = true
    let totalNumberLabel = UILabel()
    let centerImageView = UIImageView()
    let circleProgressView = CircleProgressView()
    
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
    //social network
    let facebookLogoButton = UIButton()
    let facebookTextButton = UIButton()
    let instagramLogoButton = UIButton()
    let instagramTextButton = UIButton()
    
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
        view.backgroundColor = UIColor(red: 253/255, green: 254/255, blue: 255/255, alpha: 1)
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
            let imageLink = i.imageLink ?? ""
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
                self?.ref?.child("userName").setValue(userName)
            })
                
            let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
                
            alert.addAction(submitAction)
            alert.addAction(cancelAction)
                
            self.present(alert, animated: false, completion: nil)
                
            }
            
            if (!userName.isEmpty) {
                UserDefaults.standard.set(userName, forKey: "currentUserName")
            }
            
            if imageLink != "" && self.checkImageLoad {
                self.userPhoto.imageFromURL(urlString: imageLink)
                self.userPhoto.contentMode = .scaleToFill
                self.userPhoto.layer.cornerRadius = self.userPhoto.frame.size.width / 2
                self.userPhoto.clipsToBounds = true
            } else if imageLink == "" {
                self.userPhoto.image = UIImage(named: "userPhoto")
                self.userPhoto.contentMode = .scaleToFill
                self.userPhoto.clipsToBounds = false
            }
            
            switch totalPassed {
            case 0...14:
                userStatus = "Неравнодушный"
                centerImageView.image = UIImage(named: "неравнодушный")
            case 15...24:
                userStatus = "Вовлеченный"
                centerImageView.image = UIImage(named: "вовлеченный")
            case 25...49:
                userStatus = "Заботливый"
                centerImageView.image = UIImage(named: "заботливый")
            case 50...99:
                userStatus = "Эко-Герой"
                centerImageView.image = UIImage(named: "эко-герой")
            default:
                userStatus = "Эко-Супергерой"
                centerImageView.image = UIImage(named: "экосупергерой")
            }
            
            //Setuping circleProgressView
            var circleProgressValue = 0.0

            if userStatus == "Неравнодушный" {
                goalNumber = 15 - totalPassed
                circleProgressValue = (Double((totalPassed * 100) / 50)) / 100

            } else if userStatus == "Вовлеченный" {

                goalNumber = 25 - totalPassed
                circleProgressValue = (Double((totalPassed * 100) / 150)) / 100

            } else if userStatus == "Заботливый" {

                goalNumber = 50 - totalPassed
                circleProgressValue = (Double((totalPassed * 100) / 300)) / 100

            } else if userStatus == "Эко-Герой" {

                goalNumber = 100 - totalPassed
                circleProgressValue = (Double((totalPassed * 100) / 1000)) / 100
            } else {
                goalNumber = 2000 - totalPassed
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
                self.totalNumberLabel.text = "Ваш вклад: \(totalPassed / 1000)т \(totalPassed % 1000) кг"
            } else if totalPassed < 1000 {
                self.totalNumberLabel.text = "Ваш вклад: \(totalPassed) кг"
            }
            
            if savedWaterNumber > 999 {
                numberOfWaterLabel.text = "\(savedWaterNumber / 1000)м³ \(savedWaterNumber % 1000) л"
            } else if savedWaterNumber < 1000 {
                numberOfWaterLabel.text = "\(savedWaterNumber) л"
            }
        
            self.userNameLabel.text = userName
            self.userBonusLabel.text = "Бонусы: \(userBonus)"
            self.userStatusLabel.text = "Ваш статус: \(userStatus)"
            self.goalNumberLabel.text = "\(goalNumber) кг"
            
            //Saving savedData in FireBase DataBase
            self.ref?.child("total").setValue(totalPassed)
            
            //MARK:setting alerView for Неравнодушный status
            let alertViewStatus = SCLAlertView()
            
            //checking the status and userDefaults value to avoid secong showing
            if (userStatus=="Неравнодушный" && UserDefaults.standard.object(forKey: "НеравнодушныйУвидел") == nil) {
                
                    alertViewStatus.showSuccess("Добро пожаловать!", subTitle: "\nВы уже Неравнодушный, будьте выше! Следующий статус - Вовлеченный.", closeButtonTitle: "Хорошо, я сделаю это!", duration: 0.0, colorStyle: 0x22B573, colorTextButton: 0xFFFFFF, circleIconImage: nil, animationStyle: SCLAnimationStyle.bottomToTop)
                    UserDefaults.standard.set("неравнодушному показали", forKey: "НеравнодушныйУвидел")
                
            } else if (userStatus=="Вовлеченный" && UserDefaults.standard.object(forKey: "ВовлеченныйУвидел") == nil) {
                
                alertViewStatus.showSuccess("Поздравляем", subTitle: "\nВаш статус теперь - Вовлеченный. Вы можете больше! Следующий статус - Заботливый.", closeButtonTitle: "я сделаю больше!", duration: 0.0, colorStyle: 0x22B573, colorTextButton: 0xFFFFFF, circleIconImage: nil, animationStyle: SCLAnimationStyle.topToBottom)
                UserDefaults.standard.set("вовлеченному показали", forKey: "ВовлеченныйУвидел")
                
            } else if (userStatus=="Заботливый" && UserDefaults.standard.object(forKey: "ЗаботливыйУвидел") == nil) {
                
                alertViewStatus.showSuccess("Крутоо", subTitle: "\nВы - Заботливый. Продолжайте помогать природе дальше!", closeButtonTitle: "хорошо!", duration: 0.0, colorStyle: 0x22B573, colorTextButton: 0xFFFFFF, circleIconImage: nil, animationStyle: SCLAnimationStyle.leftToRight)
                UserDefaults.standard.set("заботливому показали", forKey: "ЗаботливыйУвидел")
                
            } else if (userStatus=="Эко-Герой" && UserDefaults.standard.object(forKey: "Эко-ГеройУвидел") == nil) {
                
                alertViewStatus.showSuccess("УРАА", subTitle: "\nПоздравляем ЭКО-герой! Вы смогли сделать это!", closeButtonTitle: "стать ЭКО-супергероем", duration: 0.0, colorStyle: 0x22B573, colorTextButton: 0xFFFFFF, circleIconImage: nil, animationStyle: SCLAnimationStyle.leftToRight)
                UserDefaults.standard.set("эко-герою показали", forKey: "Эко-ГеройУвидел")
                
            } else if (userStatus=="Эко-Супергерой" && UserDefaults.standard.object(forKey: "Эко-СупергеройУвидел") == nil) {
                
                alertViewStatus.showSuccess("Невероятноо!", subTitle: "\nПоздравляем, Вы ЭКО-Супергерой! Природа нуждается в таких как Вы! Оставайтесь всегда \nЭко-супергероем", closeButtonTitle: "Продолжить", duration: 0.0, colorStyle: 0x22B573, colorTextButton: 0xFFFFFF, circleIconImage: nil, animationStyle: SCLAnimationStyle.rightToLeft)
                UserDefaults.standard.set("эко-герою показали", forKey: "Эко-СупергеройУвидел")
            }
        
        }
    }
    
    func fusumaMethod() {
        let fusuma = FusumaViewController()
        fusuma.delegate = self
        fusumaCameraTitle = "Photo"
        fusumaCameraRollTitle = "Library"
        fusumaTitleFont = UIFont(name: "AvenirNext-DemiBold", size: 14)
        fusumaSavesImage = true
        
        self.present(fusuma, animated: true, completion: nil)
        
    }
    
    //delegate of Fusuma
    func fusumaImageSelected(_ image: UIImage, source: FusumaMode) {
        self.checkImageLoad = false
        self.userPhoto.image = image
        userPhoto.contentMode = .scaleToFill
        userPhoto.layer.cornerRadius = userPhoto.frame.size.width / 2
        userPhoto.clipsToBounds = true
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultAnimationType(.native)
        SVProgressHUD.setDefaultMaskType(.gradient)
        SVProgressHUD.showSuccess(withStatus: "ваша фотография обновлена")

        let userId = Auth.auth().currentUser?.uid

            var data = Data()
            data = UIImageJPEGRepresentation(image, 0.6)!
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpg"
            
            self.storageRef.child("avatar").child((userId)! + ".jpg").putData(data, metadata: metadata, completion: { (metaData, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    self.imageLink = metaData?.downloadURL()?.absoluteString
                    self.ref = Database.database().reference().child("Users").child(userId!)
                    self.ref?.child("imageLink").setValue(self.imageLink)
                    self.checkImageLoad = true
                }
        })
        SVProgressHUD.dismiss(withDelay: 3)
        
    }
    
    func fusumaMultipleImageSelected(_ images: [UIImage], source: FusumaMode) {
        
    }
    
    func fusumaVideoCompleted(withFileURL fileURL: URL) {
      print("Called just after a video has been selected.")
    }
    
    func fusumaCameraRollUnauthorized() {
        print("Camera roll unauthorized")
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
    
    func instagramBTNpressed(sender: UIButton) {
        let image = UIImage(named: "logoTazalyk")
        let objectsToShare: [AnyObject] = [ image! ]
        let activityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }

    func settingsButtonPressed(sender: UIButton) {
        let settingsNavigationController = UINavigationController(rootViewController: SettingsViewController())
        settingsNavigationController.view.backgroundColor = UIColor.white
        settingsNavigationController.tabBarItem.image = UIImage(named: "profileIbar")
        settingsNavigationController.tabBarItem.selectedImage = UIImage(named: "profileIbarSelected")?.withRenderingMode(.alwaysOriginal)
        
        present(settingsNavigationController, animated: true, completion: nil)
        
    }
}
