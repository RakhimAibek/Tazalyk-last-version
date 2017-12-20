//  DetailedPinViewController.swift
//  Tazalyk
//
//  Created by Aibek Rakhim on 8/24/17.
//  Copyright © 2017 Next Step. All rights reserved.
//

import UIKit
import EasyPeasy

class DetailedPinViewController: UIViewController {
    
    let detailedPinImageView = UIImageView()
    let addressTextLabel = UILabel()
    let pinAddressLabel = UILabel()
    let timeTextLabel = UILabel()
    let pinTimeLabel = UILabel()
    let contactTextLabel = UILabel()
    let pinContactLabel = UILabel()
    let infoSalesLabel = UILabel()
    let ticketImageView = UIImageView()
    
    var selectedPinVar: Pin?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        configureView()
        setupConstraints()
        guard let place = selectedPinVar else { return }
        
        
        pinTimeLabel.text = place.timetable?.replacingOccurrences(of: ".", with: "\n")
        pinAddressLabel.text = place.address
        pinContactLabel.text = place.contact

        if let pinImageURL = place.imageLink {
            let url = URL(string: pinImageURL)
            URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error!, "Got error from download PinImage")
                    return
                }
            DispatchQueue.main.async {
                self.detailedPinImageView.image = UIImage(data: data!)
            }
            
           }).resume()
        }
        
        if place.sale == "yes" {
            infoSalesLabel.text = "*Сдав 1 кг вторсырья в данном пункте, Вы получите 1 бонус. За достижение отметки в 25 бонусов присуждаются призы - билет в KinoPark / билет в Медео. Акция действует с 7.12.2017 до 28.02.2018 года"
            ticketImageView.image = UIImage(named: "ticketCinema")
        }
        
    }
    
    func configureView() {
        //setting navigation bar
        navigationController?.navigationBar.tintColor = UIColor(red: 79.0/255.0, green: 87.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "backButton"), style: .plain, target: self, action: #selector(backButtonPressed(sender:)))
        navigationItem.title = "Подробная информация"
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "ProximaNova-Semibold", size: 16.0)!, NSForegroundColorAttributeName: UIColor(red: 86.0/255.0, green: 86.0/255.0, blue: 86.0/255.0, alpha: 1.0)]
        
        //Detailed
        detailedPinImageView.contentMode = .scaleAspectFit
        if detailedPinImageView.image == nil {
            self.detailedPinImageView.image = UIImage(named: "loadingDetailedImagePin")
        }
        
        
        //AdressLabel
        addressTextLabel.text = "Адрес"
        addressTextLabel.font = UIFont(name: "ProximaNova-Semibold", size: 18.0)
        addressTextLabel.textColor = UIColor(red: 86.0/255.0, green: 86.0/255.0, blue: 86.0/255.0, alpha: 1.0)
        
        pinAddressLabel.numberOfLines = 0
        pinAddressLabel.font = UIFont(name: "ProximaNova-Regular", size: 16.0)
        pinAddressLabel.text = ""
        pinAddressLabel.textColor = UIColor(red: 86.0/255.0, green: 86.0/255.0, blue: 86.0/255.0, alpha: 1.0)
        
        //TimeLabel
        timeTextLabel.text = "Режим работы:"
        timeTextLabel.font = UIFont(name: "ProximaNova-Semibold", size: 18.0)
        timeTextLabel.textColor = UIColor(red: 86.0/255.0, green: 86.0/255.0, blue: 86.0/255.0, alpha: 1.0)
        
        pinTimeLabel.numberOfLines = 0
        pinTimeLabel.font = UIFont(name: "ProximaNova-Regular", size: 16.0)
        pinTimeLabel.text = "Пн - Пт: 10:00-17:30, обед: 14:00-14:30 Сб: 10:00-15:30, обед: 13:00-13:30 Вс: Выходной"
        pinTimeLabel.textColor = UIColor(red: 86.0/255.0, green: 86.0/255.0, blue: 86.0/255.0, alpha: 1.0)
        
        //ContactLabel
        contactTextLabel.text = "Контакты:"
        contactTextLabel.font = UIFont(name: "ProximaNova-Semibold", size: 18.0)
        contactTextLabel.textColor = UIColor(red: 86.0/255.0, green: 86.0/255.0, blue: 86.0/255.0, alpha: 1.0)
        
        pinContactLabel.numberOfLines = 0
        pinContactLabel.font = UIFont(name: "ProximaNova-Regular", size: 16.0)
        pinContactLabel.text = "+7 701 721 55 72, Наталья"
        pinContactLabel.textColor = UIColor(red: 86.0/255.0, green: 86.0/255.0, blue: 86.0/255.0, alpha: 1.0)
        
        //InfoSalel Label
        infoSalesLabel.numberOfLines = 0
        infoSalesLabel.font = UIFont(name: "ProximaNova-Regular", size: 12.0)
        pinContactLabel.textColor = UIColor(red: 86.0/255.0, green: 86.0/255.0, blue: 86.0/255.0, alpha: 1.0)
        
        //TicketImage
        ticketImageView.contentMode = .scaleAspectFill
        
        [detailedPinImageView, addressTextLabel, pinAddressLabel, timeTextLabel, pinTimeLabel, contactTextLabel, pinContactLabel, infoSalesLabel, ticketImageView].forEach {
            self.view.addSubview($0)
        }
    }
    
    func setupConstraints() {
        
        detailedPinImageView <- [
            Top((self.navigationController?.navigationBar.frame.height)!*1.5),
            Left(0.0),
            Right(0.0),
            Height(114.0)
            ]
        
        addressTextLabel <- [
            Top(20.0).to(detailedPinImageView),
            Left(20.0)
        ]
        
        pinAddressLabel <- [
            Top(10.0).to(addressTextLabel),
            Left(20.0),
            Right(20.0)
        ]
        
        timeTextLabel <- [
            Top(20.0).to(pinAddressLabel),
            Left(20.0)
        ]
        
        pinTimeLabel <- [
            Top(10.0).to(timeTextLabel),
            Left(20.0),
            Right(20.0)
        ]
        
        contactTextLabel <- [
            Top(20.0).to(pinTimeLabel),
            Left(20.0)
        ]
        
        pinContactLabel <- [
            Top(10.0).to(contactTextLabel),
            Left(20.0),
            Right(20.0)
        ]
        
        infoSalesLabel <- [
            Top(20.0).to(pinContactLabel),
            Left(20.0),
            Right(10).to(ticketImageView)
        ]
        
        ticketImageView <- [
            Top(25.0).to(pinContactLabel),
            Width(33.0),
            Height(32.0),
            Right(35.0)
        ]
    }
    
    func backButtonPressed(sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
