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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        fetchAllusers()
    }
    
    func configureView() {
        
        //UILabel text of Best
        textLabel.text = "Лучшие Эко-Пользователи"
        textLabel.textColor = .black
        textLabel.font = UIFont(name: "ProximaNova-Bold", size: 18.0)
        
        //UITableView
        scoreTableView.backgroundView = UIImageView(image: UIImage(named: "cupImage"))
        scoreTableView.backgroundView?.alpha = 0.14
        scoreTableView.alpha = 1
        
        
        [backgroundCupImage, textLabel, scoreTableView].forEach {
            self.view.addSubview($0)
        }
    }
    
    //Fetching all users from FirebaseDatabase and sorting it
    func fetchAllusers() {
        
        let userRef = Database.database().reference().child("Users")
        userRef.observe(.value, with: { (snapshot) in
            
            for i in snapshot.children {
                let user = User(snapshot: i as! DataSnapshot)
                self.userArr.append(user)
            }
            
            let filtered = self.userArr.filter({ (user1) -> Bool in
                return user1.total! > 0
            })
            
            let deepFiltered = filtered.sorted(by: { (user1, user2) -> Bool in
                return user1.total! > user2.total!
            })

            self.userArr = []
            
            self.filteredUsers = deepFiltered
            
            DispatchQueue.main.async {
                self.scoreTableView.reloadData()
            }
        })
    }
    
    func configureConstraints() {
        backgroundCupImage <- [
           Edges()
        ]
        
        
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
        
        if let userNickName = sortedUser.userName, let passedTrash = sortedUser.total {
            
            cell.userNameLabel.text = userNickName
            var userStatus = ""
            
            switch passedTrash {
            case 0...50:
                userStatus = "Неравнодушный"
                cell.statusImageView.image = UIImage(named: "неравнодушный")
            case 51...100:
                userStatus = "Вовлеченный"
                cell.statusImageView.image = UIImage(named: "вовлеченный")
            case 101...200:
                userStatus = "Заботливый"
                cell.statusImageView.image = UIImage(named: "заботливый")
            case 201...500:
                userStatus = "Эко-Герой"
                cell.statusImageView.image = UIImage(named: "эко-герой")
            default:
                userStatus = "Эко-Супергерой"
                cell.statusImageView.image = UIImage(named: "супергерой")
            }
            cell.backgroundColor = .clear
            
            cell.passedStatisticLabel.text = "Статус: \(userStatus), \(passedTrash) кг сдано"
            
        }
  
        return cell
    }

}

