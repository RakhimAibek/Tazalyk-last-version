//
//  PageOnboard.swift
//  Tazalyk
//
//  Created by Aibek Rakhim on 10/6/17.
//  Copyright © 2017 Next Step. All rights reserved.
//

import Foundation

struct PageOnboard {
    let title: String
    let message: String
    let imageName: String
    
    init(title: String, message: String, imageName: String) {
        self.title = title
        self.message = message
        self.imageName = imageName
    }
    
    static func pageInfo() -> [PageOnboard] {
        return [
            PageOnboard(title: "Пункты приема твоего города", message: "Сдай мусор в пункт приема, и получи за это деньги и бонусы. Меняй бонусы на ценные призы!", imageName: "onboard1"),
            PageOnboard(title: "Будь в ТОПе рейтинга", message: "Соревнуйся с друзьями, и делись своим результатом", imageName: "onboard2"),
            PageOnboard(title: "Повышай Статус", message: "Заработай статус Эко-Супергерой, сдавая мусор на переработку", imageName: "onboard3")
        ]
    }
}
