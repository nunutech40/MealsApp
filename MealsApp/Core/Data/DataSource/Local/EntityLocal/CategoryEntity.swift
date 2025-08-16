//
//  CategoryEntity.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 16/08/25.
//

import Foundation
import RealmSwift

class CategoryEntity: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var desc: String = ""
    
    override static func primaryKey() -> String {
        return "id"
    }
}
