//
//  MealModel.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 17/09/25.
//


import Foundation

struct MealModel: Equatable, Identifiable {

  let id: String
  let title: String
  let image: String
  var category: String = ""
  var area: String = ""
  var instructions: String = ""
  var tag: String = ""
  var youtube: String = ""
  var source: String = ""
  var ingredients: [IngredientModel] = []
  var favorite: Bool = false

}
