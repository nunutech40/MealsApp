//
//  MealEntity.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 17/09/25.
//


import Foundation
import RealmSwift

class MealEntity: Object {

  @objc dynamic var id = ""
  @objc dynamic var title = ""
  @objc dynamic var image = ""
  @objc dynamic var category = ""
  @objc dynamic var area = ""
  @objc dynamic var instructions = ""
  @objc dynamic var tag = ""
  @objc dynamic var youtube = ""
  @objc dynamic var source = ""
  @objc dynamic var favorite = false

  var ingredients = List<IngredientEntity>()

  override static func primaryKey() -> String? {
    return "id"
  }
}
