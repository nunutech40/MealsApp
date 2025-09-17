//
//  APICall.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 12/08/25.
//
import Foundation
import Alamofire

struct API {
    // URL, bukan String
    static let baseURL = URL(string: "https://www.themealdb.com/api/json/v1/1/")!
}

protocol EndPoint { var url: URL { get } }

enum EndPoints {

    // Builder seragam (hindari concat mentah)
    static func build(path: String, query: [URLQueryItem] = []) -> URL {
        // pakai isDirectory: false → gak kena overload 'conformingTo'
        let url = API.baseURL.appendingPathComponent(path, isDirectory: false)
        var comps = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        comps.queryItems = query.isEmpty ? nil : query
        return comps.url!
    }

    // MARK: - GET
    enum Gets: EndPoint {
        case categories
        case meals(category: String?)
        case meal(id: String?)
        case search(query: String?)

        var url: URL {
            switch self {
            case .categories:
                return EndPoints.build(path: "categories.php")

            case .meals(let c):
                return EndPoints.build(
                    path: "filter.php",
                    query: c.map { [URLQueryItem(name: "c", value: $0)] } ?? []
                )

            case .meal(let id):
                return EndPoints.build(
                    path: "lookup.php",
                    query: id.map { [URLQueryItem(name: "i", value: $0)] } ?? []
                )

            case .search(let q):
                return EndPoints.build(
                    path: "search.php",
                    query: q.map { [URLQueryItem(name: "s", value: $0)] } ?? []
                )
            }
        }
    }

    // MARK: - POST (contoh)
    enum Post: EndPoint {
        case addFavorite(mealId: String, userId: String)
        case createMeal(name: String, category: String)

        var url: URL {
            switch self {
            case .addFavorite(let mealId, let userId):
                return EndPoints.build(
                    path: "addFavorite.php",
                    query: [
                        URLQueryItem(name: "mealID", value: mealId),
                        URLQueryItem(name: "userID", value: userId)
                    ]
                )
            case .createMeal(let name, let category):
                return EndPoints.build(
                    path: "createMeal.php",
                    query: [
                        URLQueryItem(name: "name", value: name),
                        URLQueryItem(name: "category", value: category)
                    ]
                )
            }
        }
    }
}

// Alamofire sugar: langsung bisa dipakai tanpa .url
extension EndPoints.Gets: URLConvertible { func asURL() throws -> URL { url } }
extension EndPoints.Post: URLConvertible { func asURL() throws -> URL { url } }
