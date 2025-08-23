//
//  MealRepository.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 13/08/25.
//

import Foundation
import Combine

protocol MealRepositoryProtocol {
    
    func getCategories() -> AnyPublisher<[CategoryModel], Error>
    
}

final class MealRepository: NSObject {
    
    typealias MealInstance = (RemoteDataSource, LocalDataSource) -> MealRepository
    
    fileprivate let remote: RemoteDataSource
    fileprivate let local: LocalDataSource
    
    private init(remote: RemoteDataSource, local: LocalDataSource) {
        self.remote = remote
        self.local = local
    }
    
    static let sharedInstance: MealInstance = { remoteRepo, localRepo in
        return MealRepository(remote: remoteRepo, local: localRepo)
    }
}

extension MealRepository: MealRepositoryProtocol {
    
    func getCategories() -> AnyPublisher<[CategoryModel], Error> {
        return self.local.getCategories()
            .flatMap { result -> AnyPublisher<[CategoryModel], Error> in
                if result.isEmpty {
                    return self.remote.getCategories()
                        .map { CategoryMapper.mapCategoryResponseToEntities(input: $0) }
                        .flatMap { self.local.addCategories(from: $0) }
                        .filter { $0 }
                        .flatMap { _ in self.local.getCategories()
                                .map { CategoryMapper.mapCategoryEntityToDomains(input: $0) }
                        }.eraseToAnyPublisher()
                    
                } else {
                    return self.local.getCategories()
                        .map { CategoryMapper.mapCategoryEntityToDomains(input: $0) }
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
        
    }
}
