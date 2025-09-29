//
//  MealDataSource.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 13/08/25.
//

import Foundation
import Alamofire
import Combine

protocol RemoteDataSourceProtocol {
    
    func getCategories() -> AnyPublisher<[CategoryResponse], Error>
    func getMeals(by category: String) -> AnyPublisher<[MealResponse], Error>
    func getMeal(by id: String) -> AnyPublisher<MealResponse, Error>
    func searchMeal(by title: String) -> AnyPublisher<[MealResponse], Error>
    
}

final class RemoteDataSource: NSObject {
    
    private override init() { }
    
    static let sharedInstance: RemoteDataSource = RemoteDataSource()
    
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    
    func getCategories() -> AnyPublisher<[CategoryResponse], Error> {
        return Future<[CategoryResponse], Error> { completion in
            let url = EndPoints.Gets.categories.url
            AF.request(url)
                .validate()
                .responseDecodable(of: CategoriesResponse.self) { response in
                    switch response.result {
                    case .success(let value):
                        completion(.success(value.categories))
                    case .failure:
                        completion(.failure(URLError.invalidResponse))
                    }
                }
        }.eraseToAnyPublisher()
    }

    func getMeals(by category: String) -> AnyPublisher<[MealResponse], Error> {
        return Future<[MealResponse], Error> { completion in
            let url = EndPoints.Gets.meals(category: category).url
            AF.request(url)
                .validate()
                .responseDecodable(of: MealsResponse.self) { response in
                    switch response.result {
                    case .success(let value):
                        completion(.success(value.meals))
                    case .failure:
                        completion(.failure(URLError.invalidResponse))
                    }
                }
        }.eraseToAnyPublisher()
    }
    
    func getMeal(by id: String) -> AnyPublisher<MealResponse, Error> {
        return Future<MealResponse, Error> { completion in
            let url = EndPoints.Gets.meal(id: id).url
            AF.request(url)
                .validate()
                .responseDecodable(of: MealsResponse.self) { respone in
                    switch respone.result {
                    case .success(let value):
                        completion(.success(value.meals[0]))
                    case .failure:
                        completion(.failure(URLError.invalidResponse))
                    }
                }
        }.eraseToAnyPublisher()
    }
    
    func searchMeal(
      by title: String
    ) -> AnyPublisher<[MealResponse], Error> {
      return Future<[MealResponse], Error> { completion in
          let url = EndPoints.Gets.search(query: title).url
          AF.request(url)
              .validate()
              .responseDecodable(of: MealsResponse.self) { response in
                  switch response.result {
                  case .success(let value):
                      completion(.success(value.meals))
                  case .failure(let error):
                      completion(.failure(URLError.invalidResponse))
                  }
              }
      }.eraseToAnyPublisher()
    }
}
