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

    
}
