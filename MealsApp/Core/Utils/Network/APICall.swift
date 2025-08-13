//
//  APICall.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 12/08/25.
//

import Foundation

struct API {
    
    static let baseURL = "https://www.themealdb.com/api/json/v1/1/"
}


protocol EndPoint {
    var url: String { get }
}

enum EndPoints {
    enum Gets: EndPoint {
        case categories
        case meals
        case meal
        case search
        
        public var url: String {
            switch self {
            case .categories:
                return "\(API.baseURL)categories.php"
            case .meals:
                return "\(API.baseURL)filter.php?c="
            case .meal:
                return "\(API.baseURL)lookup.php?i="
            case .search:
                return "\(API.baseURL)search.php?s="
            }
        }
    }
    
    enum Post: EndPoint {
        case addFavorite(mealId: String, userId: String)
        case createMeal(name: String, category: String)
        
        public var url: String {
            switch self {
            case .addFavorite(let mealddID, let userID):
                return "\(API.baseURL)addFavorite.php?mealID=\(mealddID)&userID=\(userID)"
            case .createMeal(let name, let category):
                return "\(API.baseURL)createMeal.php?name=\(name)&category=\(category)"
            }
        }
    }
    
    enum Deletes: EndPoint {
        case removeFavorites(mealId: String, userId: String)
        
        public var url: String {
            switch self {
            case .removeFavorites(let mealId, userId: let userId):
                return "\(API.baseURL)removeFavorite.php?mealID=\(mealId)&userID=\(userId)"
            }
        }
    }
}
