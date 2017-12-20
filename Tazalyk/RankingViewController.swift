//
//  RankingViewController.swift
//  Tazalyk
//
//  Created by Aibek Rakhim on 8/3/17.
//  Copyright © 2017 Next Step. All rights reserved.
//

import UIKit
import EasyPeasy
import SVProgressHUD
import FirebaseDatabase
import FirebaseAuth
import KFSwiftImageLoader

class RankingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // MARK: - UIElements
    let textLabel = UILabel()
    let scoreTableView = UITableView()
    
    let myPlaceLabel = UILabel()
    let myPassedTrashLabel = UILabel()
    
    var gradientLayer: CAGradientLayer!
    let topBGview = UIView()
    let myImage = UIImageView()

    // MARK: - Properties
    var rankingList = [User]()
    var ref: DatabaseReference?
    var currentUser: User?
    var myUserArr = [User]()
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello viewdidload")
        
        configureView()
        configureConstraints()
        self.view.backgroundColor = .white
        scoreTableView.rowHeight = 70
        
        //TableView
        scoreTableView.delegate = self
        scoreTableView.dataSource = self
        scoreTableView.register(RankingTableViewCell.self, forCellReuseIdentifier: "myCell")
        
        //Fetch data
        ref = Database.database().reference().child("Users")
        fetchList()
    }
    
    // MARK: - Methods
    func configureView() {
        //Gradient
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor(red: 126/255, green: 211/255, blue: 33/255, alpha: 1).cgColor, UIColor(red: 87/255, green: 150/255, blue: 18/255, alpha: 1)]
        gradientLayer.locations = [0, 1]
        self.topBGview.layer.addSublayer(gradientLayer)
        
        myPlaceLabel.numberOfLines = 2
        myPlaceLabel.textColor = UIColor.white
        myPlaceLabel.textAlignment = .center
        myPlaceLabel.font = UIFont(name: "ProximaNova-Bold", size: 16)
        
        myPassedTrashLabel.textColor = UIColor.white
        myPassedTrashLabel.textAlignment = .center
        myPassedTrashLabel.font = UIFont(name: "ProximaNova-Bold", size: 16)
        
        myImage.image = UIImage(named: "defaultUserPhoto")
        myImage.layer.cornerRadius = 40
        myImage.contentMode = .scaleAspectFill
        myImage.clipsToBounds = true
        
        //UILabel text of Best
        textLabel.text = "Лучшие Эко-Пользователи"
        textLabel.textColor = .white
        textLabel.font = UIFont(name: "ProximaNova-Bold", size: 18.0)
        
        //UITableView
        scoreTableView.alpha = 1
        
        [topBGview, textLabel, myImage, scoreTableView, myPlaceLabel, myPassedTrashLabel].forEach {
            self.view.addSubview($0)
        }
    }

    func configureConstraints() {
        
        topBGview <- [
            Top(0),
            Left(0),
            Right(0),
            Height(160)
        ]
        
        myPlaceLabel <- [
            Width(60),
            Height(40),
            Top(35).to(textLabel),
            Left(35)
        ]
        
        myPassedTrashLabel <- [
            Width(60),
            Height(40),
            Top(35).to(textLabel),
            Right(35)
        ]
        
        textLabel <- [
            Top(30),
            CenterX(0.0)
        ]
        
        myImage <- [
            Top(11).to(textLabel),
            CenterX(0).to(topBGview),
            Height(80),
            Width(80)
        ]
        
        scoreTableView <- [
            Top(0).to(topBGview),
            Left(),
            Right(),
            Bottom(50)
        ]
        
    }

    func fetchList(){
        
        //fetching data
        ref?.observe(.value, with: {(snapshot) in
            self.rankingList = [User]()
            for i in snapshot.children{
                let user = User(snapshot: i as! DataSnapshot)
                self.rankingList.append(user)
            }
            
            if UserDefaults.standard.object(forKey: "userUID") != nil {
                User.fetch(completion: { (result, error) in
                    guard let result = result else {
                        print("error User fetching")
                            return
                        }
                        self.myUserArr = result
                        if !self.myUserArr.isEmpty {
                            for i in self.myUserArr {
                                let myTotal = i.total ?? 0
                                let imageLink = i.imageLink ?? ""
                                self.myPlaceLabel.text = ""
                                self.myPassedTrashLabel.text = "\(myTotal) кг"
                                if imageLink != "" {
                                    self.myImage.imageFromURL(urlString: imageLink)
                                }
                            }
                        }
        
                    })
            }
            
            //filtering by total greater 0
            self.rankingList = self.rankingList.filter({ (user) in
                return user.total! > 0
            })
            //sorting by total
            self.rankingList = self.rankingList.sorted(by: {(user1, user2) in
                return user1.total! > user2.total!
            })
            
            DispatchQueue.main.async {
                self.scoreTableView.reloadData()
            }
            })
        }
    
    //UITableViewDelegate and UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rankingList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! RankingTableViewCell
        let user = self.rankingList[indexPath.row]
        if let userName = user.userName, let passedTrash = user.total, let imageLink = user.imageLink{
            var userStatus = ""
            switch passedTrash {
            case 0...14:
                userStatus = "Неравнодушный"
            case 15...24:
                userStatus = "Вовлеченный"
            case 25...49:
                userStatus = "Заботливый"
            case 50...99:
                userStatus = "Эко-Герой"
            default:
                userStatus = "Эко-Супергерой"
            }
            cell.passedStatisticLabel.text = userStatus
            cell.userNameLabel.text = userName
            cell.amountOfpassed.text = "\(passedTrash)"
            
            if (imageLink.count > 5){
                cell.statusImageView.loadImage(urlString: imageLink, placeholderImage: UIImage(named: "loading"), completion: nil)
            }
        }

        cell.numerationsUser.text = "\(indexPath.row+1)"
        
        var findMe = ""
        myUserArr.forEach { (u) in
            findMe = u.phoneNumber!
        }
        
        if findMe != "" {
            if user.phoneNumber == findMe {
                cell.backgroundColor = UIColor(red: 235/255, green: 242/255, blue: 251/255, alpha: 1)
                myPlaceLabel.text = "\(indexPath.row+1)\nместо"
            }
        }

        print("hello \(indexPath.row)")
        return cell
    }
    
}
