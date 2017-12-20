//
//  AuthorizationViewController.swift
//  Tazalyk
//
//  Created by Aibek Rakhim on 7/28/17.
//  Copyright © 2017 Next Step. All rights reserved.
//

import UIKit
import EasyPeasy
import FirebaseAuth
import FirebaseDatabase
import SVProgressHUD

class AuthorizationViewController: UIViewController, UITextFieldDelegate {
    
    let backgroundImageView = UIImageView()
    let overLayBackgroundView = UIView()
    let codeTextField = UITextField()
    let logoImage = UIImageView()
    let resendPhoneButton = UIButton()
    let resendCodeButton = UIButton()
    let warningError = UILabel()
    let loginButton = UIButton()
    let timerLabel = UILabel()
    
    var ref: DatabaseReference?
    var time = 40
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        constraintsSetup()
        codeTextField.delegate = self
        UIApplication.shared.statusBarStyle = .lightContent
        SVProgressHUD.setDefaultStyle(.light)
        SVProgressHUD.setDefaultAnimationType(.flat)
        SVProgressHUD.setDefaultMaskType(.gradient)
    }
    
    //User starts to edit in textField
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField: codeTextField, moveDistance: -40, up: true)
        codeTextField.layer.borderColor = UIColor.white.cgColor
    }
    
    //User starts finish editing
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField: codeTextField, moveDistance: -40, up: false)
        codeTextField.layer.borderColor = UIColor.white.cgColor
    }
    
    //MARK: MoveTextField when keyboard appears
    func moveTextField(textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    //user can type only 10 symbols by format of typing Number
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let maxLength = 6
        let currentString: NSString = codeTextField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    //Hide keyboard when user touches outside keyboar
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //Hide keyboard when return pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        codeTextField.resignFirstResponder()
        loginButton.resignFirstResponder()
        return true
    }
    
    //MARK: -SetupView
    func setupViews() {
        //backgroundImageView SetupView
        backgroundImageView.image = UIImage(named: "almatyMountain")
        backgroundImageView.contentMode = .scaleAspectFill
        
        //overLayBackgroundView SetupView
        overLayBackgroundView.backgroundColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.3)
        
        //logoImage SetupView
        logoImage.image = UIImage(named: "whiteLogo")
        
        //WarningLabel setuping
        warningError.font = UIFont(name: "ProximaNova-Regular", size: 16.0)
        warningError.textColor = UIColor(red: 255.0/255.0, green: 0.0/255.0, blue: 31.0/255.0, alpha: 1.0)
        
        //CodeTextField SetupView
        codeTextField.backgroundColor = UIColor(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: 1.0)
        codeTextField.placeholder = "Введите 6-значный код"
        codeTextField.font = UIFont(name: "ProximaNova-Bold", size: 16.0)
        codeTextField.textAlignment = .center
        codeTextField.clearButtonMode = .whileEditing
        codeTextField.keyboardType = .phonePad
        codeTextField.layer.cornerRadius = 7.0
        codeTextField.layer.shadowColor = (UIColor(red: 109.0/255.0, green: 168.0/255.0, blue: 207.0/255.0, alpha: 1.0)).cgColor
        codeTextField.layer.shadowRadius = 1.0
        codeTextField.layer.borderWidth = 1
        
        //LoginButton SetupView
        loginButton.backgroundColor = UIColor(red: 109.0/255.0, green: 168.0/255.0, blue: 207.0/255.0, alpha: 1.0)
        loginButton.layer.cornerRadius = 7.0
        loginButton.setTitle("Войти", for: .normal)
        loginButton.titleLabel?.font = UIFont(name: "ProximaNova-Bold", size: 18.0)
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.setTitleColor(UIColor(red: 219.0/255, green: 219.0/255, blue: 219.0/255, alpha: 0.7), for: .highlighted)
        loginButton.addTarget(self, action: #selector(loginButtonPressed(sender:)), for: .touchUpInside)
        
        //Resend Phone Number SetupView
        resendPhoneButton.titleLabel?.font = UIFont(name: "ProximaNova-Semibold", size: 14.0)
        resendPhoneButton.setTitle("Неверный номер?", for: .normal)
        resendPhoneButton.setTitleColor(UIColor.white, for: .normal)
        resendPhoneButton.setTitleColor(UIColor(red: 109.0/255.0, green: 168.0/255.0, blue: 207.0/255.0, alpha: 1.0), for: .highlighted)
        resendPhoneButton.titleLabel?.textAlignment = .right
        resendPhoneButton.addTarget(self, action: #selector(resendPhoneNo(sender:)), for: .touchUpInside)
        
        //ResendCode Button SetupView
        resendCodeButton.titleLabel?.font = UIFont(name: "ProximaNova-Semibold", size: 13.0)
//        resendCodeButton.setTitle("Код не пришел?", for: .normal)
        resendCodeButton.setTitleColor(UIColor.white, for: .normal)
        resendCodeButton.setTitleColor(UIColor(red: 109.0/255.0, green: 168.0/255.0, blue: 207.0/255.0, alpha: 1.0), for: .highlighted)
        resendCodeButton.titleLabel?.textAlignment = .center
        resendCodeButton.addTarget(self, action: #selector(resendCode(sender:)), for: .touchUpInside)
        
        //TimerLabel text
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(actionTimer), userInfo: nil, repeats: true)
        timerLabel.adjustsFontSizeToFitWidth = true
        timerLabel.font = UIFont(name: "ProximaNova-Semibold", size: 16.0)
        timerLabel.textColor = UIColor(red: 109.0/255.0, green: 168.0/255.0, blue: 207.0/255.0, alpha: 1.0)
        
        [backgroundImageView, overLayBackgroundView, logoImage, warningError, codeTextField, loginButton, resendPhoneButton, resendCodeButton, timerLabel].forEach {
            self.view.addSubview($0)
        }
    }
    
    //MARK: -Constraints
    func constraintsSetup() {
        //backgroundImageView Constraints
        backgroundImageView <- Edges()
        
        //overLayBackgroundView Constraints
        overLayBackgroundView <- Edges()
        
        //logoImage constraints
        logoImage <- [
            CenterX(0.0),
            Top(76.0),
            Width(209.0),
            Height(50.0)
        ]
        
        //WarningLabel constraints
        warningError <- [
            CenterX(0.0),
            Bottom(25.0).to(codeTextField)
        ]
        
        //codeTextField Constraints
        codeTextField <- [
            Top(144.0).to(logoImage),
            Left(38.0).to(view),
            Right(38.0).to(view),
            Height(48.0)
        ]
        
        //loginButtonPressed Constraints
        loginButton <- [
            CenterX(0.0),
            Top(20.0).to(codeTextField),
            Left(38.0).to(view),
            Right(38.0).to(view),
            Height(48.0)
        ]
        
        //ResendPhonNO Constraints
        resendPhoneButton <- [
            Top(20.0).to(loginButton),
            Right(38.0).to(view)
        ]
        
        //ResendCodeBTN Constraints
        resendCodeButton <- [
            CenterX(0.0),
            Bottom(10)
        ]
        
        //TimerLabel 
        timerLabel <- [
            Bottom(7.0).to(codeTextField),
            Right(33.0).to(view),
            Left(33.0).to(view)
        ]
    }
    
    //ActionTimer
    func actionTimer() {
        time -= 1
        timerLabel.text = "Код поступит в течение 0:\(time) секунд"
        
        if time == 0  {
            timer.invalidate()
        }

    }
    
    
    // MARK: - Animation of WarningLabel
    func displayWarningLabel(with text: String) {
        warningError.text = text
        
        UIView.animate(withDuration: 3, delay: 0, options: [.transitionFlipFromTop], animations: {
            [weak self] in
            
            self?.warningError.alpha = 1
            
        }) { [weak self] (complete) in
            self?.warningError.alpha = 0
        }
    }
    
    //LoginButton Pressed
    func loginButtonPressed(sender: UIButton) {
        
        if codeTextField.text != "" && (codeTextField.text?.characters.count)! >= 6 {
            
            codeTextField.layer.borderColor = (UIColor(red: 74.0/255.0, green: 144.0/255.0, blue: 226.0/255.0, alpha: 1)).cgColor
            SVProgressHUD.show(withStatus: "Проверяем код...")
            
            //MARK: -FireBase
            let defaults = UserDefaults.standard
            let defaultsString = defaults.string(forKey: "verificationId")
                
            let credential: PhoneAuthCredential = PhoneAuthProvider.provider().credential(withVerificationID: defaultsString!, verificationCode: codeTextField.text!)
            
            //Auth
            Auth.auth().signIn(with: credential, completion: { [weak self] (user, error) in
                
            if error != nil {
                SVProgressHUD.showError(withStatus: "Код введен неверно..")
                print("Authorization error \(String(describing: error?.localizedDescription))")
                SVProgressHUD.dismiss(withDelay: 1.5)
                
            } else {
                let userInfo = user?.providerData[0]
                print("ProviderId \(String(describing: userInfo?.providerID))")
                
                Database.database().reference().child("Users").child((user?.uid)!).child("userRole").observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    if let userRole = snapshot.value as? String {
                        if userRole == "admin" {
                            let adminDefaults = UserDefaults.standard
                            adminDefaults.set(Auth.auth().currentUser?.uid, forKey: "adminRole")
                            adminDefaults.synchronize()
                            
                            SVProgressHUD.dismiss(completion: { 
                                let adminVC = AdminViewController()
                                self?.present(adminVC, animated: true, completion: nil)
                            })
                            
                        } else {
//                            self?.ref = Database.database().reference()
//                            self?.ref?.child("Users").child((user?.uid)!).child("phoneNumber").setValue(user?.phoneNumber)
//                            self?.ref?.child("Users").child((user?.uid)!).child("userRole").setValue("user")
//                            self?.ref?.child("Users").child((user?.uid)!).child("userName").setValue("")

////                            let phoneNumber = data["phoneNumber"] as? String ?? ""

////                            let userBonus = data["bonus"] as? Int ?? 0
////                            let totalPassed = data["total"] as? Int ?? 0
////                            let imageLink = data["imageLink"] as? String ?? ""
                            
                            //save user uid in UserDefaults
                            defaults.set(Auth.auth().currentUser?.uid, forKey: "userUID")
                            defaults.synchronize()
                            
                            SVProgressHUD.dismiss(completion: { 
                                let tabBarVC = TabBarViewController()
                                self?.present(tabBarVC, animated: true, completion: nil)
                            })
                        }
                        
                    } else {

                        //write in DataBase
                        self?.ref = Database.database().reference()
                        self?.ref?.child("Users").child((user?.uid)!).child("phoneNumber").setValue(user?.phoneNumber)
                        self?.ref?.child("Users").child((user?.uid)!).child("userRole").setValue("user")
                        self?.ref?.child("Users").child((user?.uid)!).child("userName").setValue("")
                        self?.ref?.child("Users").child((user?.uid)!).child("bonus").setValue(0)
                        self?.ref?.child("Users").child((user?.uid)!).child("total").setValue(0)
                        self?.ref?.child("Users").child((user?.uid)!).child("imageLink").setValue("")
                        
                        
                        
                        //save user uid in UserDefaults
                        defaults.set(Auth.auth().currentUser?.uid, forKey: "userUID")
                        defaults.synchronize()
                        
                        SVProgressHUD.dismiss(completion: { 
                            let tabBarVC = TabBarViewController()
                            self?.present(tabBarVC, animated: true, completion: nil)
                        })
                       
                    }
                    
                })
                }
            })
            
        } else if codeTextField.text! == "" || (codeTextField.text?.characters.count)! < 6 {
            displayWarningLabel(with: "Код должен быть 6-ти значным")
            codeTextField.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    //ReSendPhoneBTN pressed
    func resendPhoneNo(sender: UIButton) {
        
        let resendPhoneAlert = UIAlertController(title: "Изменение номера", message: "Отправить код на другой номер?", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Да", style: .default, handler: { [weak self] (UIAlertAction) in
            
            let loginVC = LoginViewController()
            self?.present(loginVC, animated: true, completion: nil)

        })
        
        let cancel = UIAlertAction(title: "Нет", style: .destructive, handler: nil)
        
        resendPhoneAlert.addAction(action)
        resendPhoneAlert.addAction(cancel)
        self.present(resendPhoneAlert, animated: true, completion: nil)
    
    }
    
    //ResendCodeBTN pressed
    func resendCode(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
