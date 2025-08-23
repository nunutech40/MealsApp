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
    var url: URL { get }
}

enum EndPoints {
    enum Gets: EndPoint {
        case categories
        case meals
        case meal
        case search
        
        public var urlString: String {
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
        
        // Sebuah computed property yang mengembalikan objek URL
        public var url: URL {
            // URL(string:) adalah failable initializer, jadi kita harus menanganinya.
            // Menggunakan preconditionFailure adalah cara yang baik untuk crash
            // saat development jika URL-nya salah ketik, mencegah bug di produksi.
            guard let url = URL(string: self.urlString) else {
                preconditionFailure("Invalid URL string: \(self.urlString)")
            }
            return url
        }
    }
    
    enum Post: EndPoint {
        case addFavorite(mealId: String, userId: String)
        case createMeal(name: String, category: String)
        
        // 1. Buat string URL di properti privat
        private var urlString: String {
            switch self {
            case .addFavorite(let mealId, let userId):
                return "\(API.baseURL)addFavorite.php?mealID=\(mealId)&userID=\(userId)"
            case .createMeal(let name, let category):
                return "\(API.baseURL)createMeal.php?name=\(name)&category=\(category)"
            }
        }
        
        // 2. Kembalikan URL non-opsional yang aman
        public var url: URL {
            guard let url = URL(string: self.urlString) else {
                preconditionFailure("Invalid URL string: \(self.urlString)")
            }
            return url
        }
    }
    
    enum Deletes: EndPoint {
        case removeFavorites(mealId: String, userId: String)
        
        private var urlString: String {
            switch self {
            case .removeFavorites(let mealId, let userId):
                return "\(API.baseURL)removeFavorite.php?mealID=\(mealId)&userID=\(userId)"
            }
        }
        
        // 3. DIPERBAIKI: Sekarang mengembalikan URL, sesuai kontrak.
        public var url: URL {
            guard let url = URL(string: self.urlString) else {
                preconditionFailure("Invalid URL string: \(self.urlString)")
            }
            return url
        }
    }
}
