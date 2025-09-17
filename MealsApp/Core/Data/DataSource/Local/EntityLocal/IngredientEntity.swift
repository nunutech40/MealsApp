//
//  IngredientEntity.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 17/09/25.
//

import Foundation
import RealmSwift

class IngredientEntity: Object {

  @objc dynamic var id: String = ""
  @objc dynamic var title: String = ""
  @objc dynamic var idMeal: String = ""

}
