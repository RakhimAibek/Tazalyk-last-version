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

class RankingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let backgroundCupImage = UIImageView()
    let overLayView = UIView()
    let textLabel = UILabel()
    let scoreTableView = UITableView()
    
    var userArr = [User]()
    var filteredUsers = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureConstraints()
        self.view.backgroundColor = .white
        scoreTableView.rowHeight = 60
        
        //TableView
        scoreTableView.delegate = self
        scoreTableView.dataSource = self
        scoreTableView.register(RankingTableViewCell.self, forCellReuseIdentifier: "myCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchAllusers()
    }
    
    func configureView() {
        
        backgroundCupImage.image = UIImage(named: "cupImage")
        backgroundCupImage.contentMode = .scaleAspectFit
        backgroundCupImage.alpha = 0.23
        overLayView.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.47)
        
        //UILabel text of Best
        textLabel.text = "Лучшие"
        textLabel.textColor = .black
        textLabel.font = UIFont(name: "ProximaNova-Bold", size: 18.0)
        
        //UITableView
        scoreTableView.backgroundColor = .white
        scoreTableView.alpha = 0.66
        
        
        [backgroundCupImage, overLayView, textLabel, scoreTableView].forEach {
            self.view.addSubview($0)
        }
    }
    
    //Fetching all users from FirebaseDatabase and sorting it
    func fetchAllusers() {
        if userArr.isEmpty == false {
            print("don`t need to SVP")
        } else {
            SVProgressHUD.show(withStatus: "Загружаю..")
        }
        
        
        let userRef = Database.database().reference().child("Users")
        userRef.observe(.value, with: { (snapshot) in
            
            for i in snapshot.children {
                let user = User(snapshot: i as! DataSnapshot)
                self.userArr.append(user)
            }
            
            let filtered = self.userArr.filter({ (user1) -> Bool in
                return user1.totalPassed! > 0
            })
            
            let deepFiltered = filtered.sorted(by: { (user1, user2) -> Bool in
                return user1.totalPassed! > user2.totalPassed!
            })

            self.userArr = []
            
            self.filteredUsers = deepFiltered
            
            DispatchQueue.main.async {
                self.scoreTableView.reloadData()
            }
        })
        SVProgressHUD.dismiss()
    }
    
    func configureConstraints() {
        backgroundCupImage <- [
           Edges()
        ]
        
        overLayView <- Edges()
        
        textLabel <- [
            Top(40.0),
            CenterX(0.0)
        ]
        
        scoreTableView <- [
            Top(21.0).to(textLabel),
            Left(),
            Right(),
            Bottom()
        ]
        
    }
    
    //UITableViewDelegate and UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredUsers.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! RankingTableViewCell
        
        let sortedUser = filteredUsers[indexPath.row]
        
        if let userNickName = sortedUser.userName, let passedTrash = sortedUser.totalPassed {
            
            cell.userNameLabel.text = userNickName
            cell.passedStatisticLabel.text = "Статус: \(sortedUser.status ?? ""), \(passedTrash) кг сдано"
            
            switch sortedUser.status ?? "" {
            case "Неравнодушный":
                cell.statusImageView.image = UIImage(named: "неравнодушный")
            case "Вовлеченный":
                cell.statusImageView.image = UIImage(named: "вовлеченный")
            case "Заботливый":
                cell.statusImageView.image = UIImage(named: "заботливый")
            case "Эко-Герой":
                cell.statusImageView.image = UIImage(named: "эко-герой")
            case "Эко-Супергерой":
                cell.statusImageView.image = UIImage(named: "супергерой")
            default:
                cell.statusImageView.image = UIImage(named: "no-image")
            }
            
            
        }
  
        return cell
    }

}

