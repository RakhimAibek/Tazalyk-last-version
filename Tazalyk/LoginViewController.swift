//  LoginViewController.swift
//  Tazalyk
//  Created by Aibek Rakhim on 7/27/17.
//  Copyright © 2017 Next Step. All rights reserved.
//

import UIKit
import EasyPeasy

class LoginViewController: UIViewController, UITextFieldDelegate {

    let bgImage = UIImageView()
    let bgShadow = UIView()
    let logoImage = UIImageView()
    let numberFormatView = UIView()
    let formatLabelText = UILabel()
    let holdView = UIView()
    let numberTextField = UITextField()
    let sendCodeButton = UIButton()
    let missButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setViews()
        setConstraints()
        numberTextField.delegate = self
    }
    
    func setViews() {
        //bgImage setuping
        bgImage.image = UIImage(named: "almatyBao")
        bgImage.contentMode = .scaleAspectFill
        
        //bgShadow setuping
        bgShadow.backgroundColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.4)
        
        //logoImage setuping
        logoImage.image = UIImage(named: "whiteLogo")
        
        //Number format setuping
        numberFormatView.backgroundColor = UIColor(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: 1)
        numberFormatView.layer.borderColor = UIColor.white.cgColor
        numberFormatView.layer.borderWidth = 1
        formatLabelText.text = "+7"
        formatLabelText.textColor = UIColor(red: 73.0/255.0, green: 144.0/255.0, blue: 226.0/255.0, alpha: 50)
        formatLabelText.font = UIFont(name: "ProximaNova-Bold", size: 16.0)
        numberFormatView.addSubview(formatLabelText)
        
        //NO textField setuping
        numberTextField.backgroundColor = UIColor(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: 1)
//        numberTextField.layer.cornerRadius = 0
        numberTextField.layer.borderWidth = 1
        numberTextField.layer.borderColor = UIColor.white.cgColor
        numberTextField.placeholder = "Введите номер"
        numberTextField.textColor = UIColor(red: 73.0/255.0, green: 144.0/255.0, blue: 226.0/255.0, alpha: 50)
        numberTextField.font = UIFont(name: "ProximaNova-Bold", size: 16.0)
        numberTextField.textAlignment = .center
        numberTextField.clearButtonMode = .whileEditing
        numberTextField.keyboardType = .phonePad
        
        //SendCodeBTN setuping
        sendCodeButton.backgroundColor = UIColor(red: 109.0/255.0, green: 168.0/255.0, blue: 207.0/255.0, alpha: 1)
        sendCodeButton.layer.cornerRadius = 7
        sendCodeButton.setTitle("Получить код", for: .normal)
        sendCodeButton.titleLabel?.font = UIFont(name: "ProximaNova-Bold", size: 18.0)
        sendCodeButton.setTitleColor(UIColor.white, for: .normal)
        sendCodeButton.setTitleColor(UIColor(red: 219.0/255, green: 219.0/255, blue: 219.0/255, alpha: 0.7), for: .highlighted)
        sendCodeButton.addTarget(self, action: #selector(sendCodeBTNpressed), for: .touchUpInside)
        
        //missButton setuping
        missButton.setTitle("Позже", for: .normal)
        missButton.setTitleColor(UIColor(red: 146.0/255.0, green: 214.0/255.0, blue: 255.0/255.0, alpha: 1), for: .normal)
        missButton.setTitleColor(UIColor.white, for: .highlighted)
        missButton.titleLabel?.font = UIFont(name: "ProximaNova-Semibold", size: 16.0)
        missButton.addTarget(self, action: #selector(missButtonPressed), for: .touchUpInside)
        
        //holdView setuping
        holdView.addSubview(numberFormatView)
        holdView.addSubview(numberTextField)
        holdView.layer.cornerRadius = 7.0
        holdView.clipsToBounds = true
        
        //adding UIElements to superView
        [bgImage, bgShadow, logoImage, holdView, sendCodeButton, missButton].forEach {
            view.addSubview($0)
        }
        
    }
    
    func setConstraints() {
        //bgImage constraints
        bgImage <- Edges()
        bgShadow <- Edges()
        
        //logoImage constraints
        logoImage <- [
            CenterX(0.0),
            Top(76.0),
            Width(209.0),
            Height(50.0)
        ]
        
        //HoldView Constraints
        holdView <- [
            CenterX(0.0),
            Top(142.0).to(logoImage),
            Left(38.0).to(view),
            Right(38.0).to(view),
            Height(48.0)
        ]
        
        //formatLabel +7
        formatLabelText <- [
            CenterX(0.0).to(numberFormatView),
            CenterY(0.0).to(numberFormatView)
        ]
        
        //NumberFormat
        numberFormatView <- [
            Top(0.0),
            Left(0.0),
            Bottom(0.0),
            Width(60.0)
        ]
        
        //NO textField constraints
        numberTextField <- [
            Top(0.0),
            Left().to(numberFormatView),
            Right(0.0),
            Bottom(0.0)
        ]
        
        //SendCode Button constraints
        sendCodeButton <- [
            CenterX(0.0),
            Top(20.0).to(numberTextField),
            Left(38.0),
            Right(38.0),
            Height(48.0)
        ]
        
        //missButton constraits
        missButton <- [
            CenterX(0.0),
            Bottom(10.0)
        ]
    }
    
    //movingTextFIeld
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField: numberTextField, moveDistance: -40, up: true)
        numberTextField.layer.borderColor = UIColor.white.cgColor
        numberFormatView.layer.borderColor = UIColor.white.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField: numberTextField, moveDistance: -40, up: false)
        numberTextField.layer.borderColor = UIColor.white.cgColor
        numberFormatView.layer.borderColor = UIColor.white.cgColor
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
        numberTextField.layer.borderColor = UIColor.white.cgColor
        numberFormatView.layer.borderColor = UIColor.white.cgColor
        
        let maxLength = 10
        let currentString: NSString = numberTextField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    //Hide keyboard when user touches outside keyboar
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //Hide keyboard when return pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        numberTextField.resignFirstResponder()
        sendCodeButton.resignFirstResponder()
        return true
    }
}
