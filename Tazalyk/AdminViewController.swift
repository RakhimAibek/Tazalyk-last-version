//
//  AdminViewController.swift
//  Tazalyk
//
//  Created by Aibek Rakhim on 8/19/17.
//  Copyright © 2017 Next Step. All rights reserved.

import UIKit
import EasyPeasy
import FirebaseAuth
import FirebaseDatabase

class AdminViewController: UIViewController, UITextFieldDelegate {
    
    let phoneNumberTextField = UITextField()
    let typeNumberOfBonus = UITextField()
    let sendBonusButton = UIButton()
    let sendTrashButton = UIButton()
    let logOutButton = UIButton()
    
    var ref: DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureConstraints()
        phoneNumberTextField.delegate = self
        self.view.backgroundColor = .white
        
    }
    
    func configureView() {
        
        phoneNumberTextField.text = "+7"
        phoneNumberTextField.layer.borderColor = UIColor(red: 109.0/255.0, green: 168.0/255.0, blue: 207.0/255.0, alpha: 1.0).cgColor
        phoneNumberTextField.backgroundColor = UIColor(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: 1.0)
        phoneNumberTextField.layer.cornerRadius = 7.0
        phoneNumberTextField.keyboardType = .phonePad
        
        typeNumberOfBonus.placeholder = "Сколько сдал?"
        typeNumberOfBonus.layer.borderColor = UIColor(red: 109.0/255.0, green: 168.0/255.0, blue: 207.0/255.0, alpha: 1.0).cgColor
        typeNumberOfBonus.backgroundColor = UIColor(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: 1.0)
        typeNumberOfBonus.layer.cornerRadius = 7.0
        typeNumberOfBonus.keyboardType = .phonePad
        
        sendBonusButton.backgroundColor = UIColor(red: 109.0/255.0, green: 168.0/255.0, blue: 207.0/255.0, alpha: 0.90)
        sendBonusButton.layer.cornerRadius = 7.0
        sendBonusButton.setTitle("Отнять", for: .normal)
        sendBonusButton.setTitleColor(.white, for: .normal)
        sendBonusButton.titleLabel?.font = UIFont(name: "ProximaNova-Bold", size: 16.0)
        sendBonusButton.setTitleColor(UIColor(red: 219.0/255, green: 219.0/255, blue: 219.0/255, alpha: 0.7), for: .highlighted)
        sendBonusButton.addTarget(self, action: #selector(sendBTNpressed(sender:)), for: .touchUpInside)
        
        sendTrashButton.backgroundColor = UIColor(red: 109.0/255.0, green: 168.0/255.0, blue: 207.0/255.0, alpha: 0.90)
        sendTrashButton.layer.cornerRadius = 7.0
        sendTrashButton.setTitle("Добавить", for: .normal)
        sendTrashButton.setTitleColor(.white, for: .normal)
        sendTrashButton.titleLabel?.font = UIFont(name: "ProximaNova-Bold", size: 16.0)
        sendTrashButton.setTitleColor(UIColor(red: 219.0/255, green: 219.0/255, blue: 219.0/255, alpha: 0.7), for: .highlighted)
        sendTrashButton.addTarget(self, action: #selector(sendBTNpressed(sender:)), for: .touchUpInside)

        logOutButton.setImage(#imageLiteral(resourceName: "signOutButton"), for: .normal)
        logOutButton.addTarget(self, action: #selector(logOutBTNpressed(sender:)), for: .touchUpInside)
        
        [phoneNumberTextField, typeNumberOfBonus, sendBonusButton, logOutButton, sendTrashButton].forEach {
            self.view.addSubview($0)
        }
    }
    
    func configureConstraints() {
        
        phoneNumberTextField <- [
            CenterX(0.0),
            Top(129.0),
            Left(38.0),
            Right(38.0),
            Height(48.0)
        ]
        
        typeNumberOfBonus <- [
            CenterX(0.0),
            Top(25.0).to(phoneNumberTextField),
            Left(38.0),
            Right(38.0),
            Height(48.0)
        ]
        
        sendBonusButton <- [
            CenterX(0.0),
            Top(25.0).to(typeNumberOfBonus),
            Left(38.0),
            Right(38.0),
            Height(48.0)
        ]
        
        sendTrashButton <- [
            CenterX(0.0),
            Top(25.0).to(sendBonusButton),
            Left(38.0),
            Right(38.0),
            Height(48.0)
        ]
        
        logOutButton <- [
            Height(21.0),
            Width(22.0),
            Top(40.0),
            Right(20.0)
        ]
        
    }
    
    //User starts to edit in textField
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField: phoneNumberTextField, moveDistance: -40, up: true)
        phoneNumberTextField.layer.borderColor = UIColor.white.cgColor
    }
    
    //User starts finish editing
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField: phoneNumberTextField, moveDistance: -40, up: false)
        phoneNumberTextField.layer.borderColor = UIColor.white.cgColor
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
    
    //user can type only 12 symbols by format of typing Number
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let maxLength = 12
        let currentString: NSString = phoneNumberTextField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    //Hide keyboard when user touches outside keyboar
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //Hide keyboard when return pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        phoneNumberTextField.resignFirstResponder()
        sendBonusButton.resignFirstResponder()
        return true
    }
    
    func configureDatabase(boolValue: Bool) {
        
        //Setuping Date to send in firebase database
        var bonusNumber = 0
        
        if let unwrappedbonusNumber = Int(typeNumberOfBonus.text!) {
            bonusNumber = unwrappedbonusNumber
        }
        
        var userArr = [User]()
        var selectedUserId: User?
        
        var idArray = [String]()
        var selectedId = ""
        
        self.ref = Database.database().reference()
        
        let userRef = Database.database().reference().child("Users")
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            for i in snapshot.children {
                let user = User(snapshot: i as! DataSnapshot)
                userArr.append(user)
                idArray.append((i as AnyObject).key)
            }
            
            for i in userArr {
                if i.phoneNumber == self.phoneNumberTextField.text {
                    selectedUserId = i
                    selectedId = idArray[(userArr.index{$0 === selectedUserId})!]
                }
                
            }
            
            if boolValue == true {
                
                if selectedId != "" {
                userRef.child(selectedId).observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    let user = User(snapshot: snapshot)
                    userRef.child(selectedId).updateChildValues(["bonus": user.bonus! + bonusNumber, "total": user.total! + bonusNumber])
                    
                })
                }
                
            } else {
                if selectedId != "" {
                Database.database().reference().child("Users").child(selectedId).child("bonus").observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    let userBonus = snapshot.value as? Int ?? 0
                    
                    Database.database().reference().child("Users").child(selectedId).child("bonus").setValue(userBonus-bonusNumber)
                    
                })
                }
                
            }
            
        })
}
    
    //Substract bonus
    func sendBTNpressed(sender: UIButton) {
        let alert = UIAlertController(title: "Проведение транзакций", message: "Вы подтверждаете свое действие?", preferredStyle: .alert)
        let action = UIAlertAction(title: "Да", style: .default, handler: { [weak self] (UIAlertAction) in
            
            if sender.currentTitle == "Отнять" {
                self?.configureDatabase(boolValue: false)
            } else {
                self?.configureDatabase(boolValue: true)
            }
            
        })
        
        let cancel = UIAlertAction(title: "Нет", style: .destructive, handler: nil)
        
        alert.addAction(action)
        alert.addAction(cancel)
        
        self.present(alert, animated: false, completion: nil)
    
    }
    
    func logOutBTNpressed(sender: UIButton) {
        
        let alert = UIAlertController(title: "Вы хотите выйти?", message: "Ваш Admin профиль не будет доступен", preferredStyle: .alert)
        let action = UIAlertAction(title: "Да", style: .default, handler: { [weak self] (UIAlertAction) in
            
            do {
                try Auth.auth().signOut()
                
                if Auth.auth().currentUser == nil {
                    UserDefaults.standard.removeObject(forKey: "adminRole")
                    UserDefaults.standard.synchronize()
                    
                    let firstVC = FirstViewController()
                    self?.present(firstVC, animated: true, completion: nil)
                }
                
            } catch let signOutError as NSError {
                print(signOutError.localizedDescription)
            }
        })
        
        let cancel = UIAlertAction(title: "Нет", style: .destructive, handler: nil)
        
        alert.addAction(action)
        alert.addAction(cancel)
        
        self.present(alert, animated: false, completion: nil)

    }
}
