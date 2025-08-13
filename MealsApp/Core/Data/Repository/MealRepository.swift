//
//  MealRepository.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 13/08/25.
//

import Foundation

protocol MealRepositoryProtocol {
    
    func getCategories(result: @escaping (Result<[CategoryModel], Error>) -> Void)
    
}

final class MealRepository: NSObject {
    
    typealias MealInstance = (RemoteDataSource) -> MealRepository
    
    fileprivate let remote: RemoteDataSource
    
    private init(remote: RemoteDataSource) {
        self.remote = remote
    }
    
    static let sharedInstance: MealInstance = { remoteRepo in
        return MealRepository(remote: remoteRepo)
    }
}

extension MealRepository: MealRepositoryProtocol {
    func getCategories(result: @escaping (Result<[CategoryModel], any Error>) -> Void) {
        self.remote.getCategories { remoteResponse in
            switch remoteResponse {
            case .success(let categoryResponse):
                let resultList = CategoryMapper.mapCategoryResponseToDomains(input: categoryResponse)
                result(.success(resultList))
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
}
