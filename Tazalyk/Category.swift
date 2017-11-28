//
//  TypeWaste.swift
//  Tazalyk
//
//  Created by Aibek Rakhim on 8/1/17.
//  Copyright © 2017 Next Step. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Category: NSObject {
    
    let id: String?
    let name: String?
    
    init(id: String?, name: String?) {
        self.id = id
        self.name = name
    }
    
    static func loadCategories() -> [Category] {
        return [
          Category(id: "000", name: "Все"),
          Category(id: "001", name: "Макулатура"),
          Category(id: "002", name: "Пластик"),
          Category(id: "003", name: "Электроника"),
          Category(id: "004", name: "Стекло"),
          Category(id: "005", name: "Опасные"),
          Category(id: "006", name: "Медицинские"),
          Category(id: "007", name: "Металл"),
          Category(id: "008", name: "Текстиль")
        ]
    }
}
