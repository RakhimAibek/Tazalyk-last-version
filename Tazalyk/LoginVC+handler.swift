//
//  LoginVC+handler.swift
//  Tazalyk
//
//  Created by Aibek Rakhim on 8/3/17.
//  Copyright © 2017 Next Step. All rights reserved.
//

import UIKit
import FirebaseAuth
import SVProgressHUD

extension LoginViewController {
    
    func missButtonPressed() {
        let tabBarVC = TabBarViewController()
        present(tabBarVC, animated: true, completion: nil)
    }
    
    func sendCodeBTNpressed() {
        
        if numberTextField.text != "" && (numberTextField.text?.characters.count)! >= 10 {
            
            numberTextField.layer.borderColor = (UIColor(red: 74.0/255.0, green: 144.0/255.0, blue: 226.0/255.0, alpha: 1)).cgColor
            numberFormatView.layer.borderColor = (UIColor(red: 74.0/255.0, green: 144.0/255.0, blue: 226.0/255.0, alpha: 1)).cgColor
            numberTextField.layer.borderWidth = 1
            
            //Alert to verificationNumber
            let userNumber = formatLabelText.text! + numberTextField.text!
            let alert = UIAlertController(title: "Проверьте свои номер в правильности", message: "Это Ваш номер телефона \(userNumber)?", preferredStyle: .alert)
            let action = UIAlertAction(title: "Да", style: .default, handler: { [weak self] (UIAlertAction) in
                
                SVProgressHUD.show(withStatus: "Авторизация...")
                
                //PhoneVerification
                PhoneAuthProvider.provider().verifyPhoneNumber("\(userNumber)", completion: { (verificationCode, error) in
                    
                    if error != nil {
                        print(error.debugDescription, "debug error desc")
                        SVProgressHUD.showError(withStatus: "Ошибка.. Попробуйте еще")
                        SVProgressHUD.dismiss(withDelay: 1.5)
                        print("Verification error \(String(describing: error?.localizedDescription))")
                        
                    } else {
                        
                        //MARK: UserDefaults
                        let defaults = UserDefaults.standard
                        defaults.set(verificationCode!, forKey: "verificationId")
                        print(verificationCode!, "verification code")
                        SVProgressHUD.dismiss(completion: {
                            SVProgressHUD.showSuccess(withStatus: "Код успешно отправлен")
                            SVProgressHUD.dismiss(withDelay: 1.5)
                            let authVC = AuthorizationViewController()
                            self?.present(authVC, animated: true, completion: nil)
                        })
                    }
                })
            })
            
            let cancel = UIAlertAction(title: "Нет", style: .destructive, handler: nil)
            
            alert.addAction(action)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
            
        } else {
            numberTextField.layer.borderColor = UIColor.red.cgColor
            numberFormatView.layer.borderColor = UIColor.red.cgColor
        }
    }
}
