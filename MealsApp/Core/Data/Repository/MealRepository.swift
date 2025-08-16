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
    func getCategories(result: @escaping (Result<[CategoryModel], any Error>) -> Void) {
        
        // get categories dari localdb
        self.local.getCategories { localResponse in
            switch localResponse {
            case.success(let categoryEntity):
                let categoryList = CategoryMapper.mapCategoryEntityToDomains(input: categoryEntity)
                // cek jika kosong, ambil data dari remote jika tidak kosong result teruskan ke success (masuk ke usecase)
                if categoryList.isEmpty {
                    // ambil dari remote
                    self.remote.getCategories { remoteResult in
                        switch remoteResult {
                        case .success(let categoryResponses):
                            let categoryEntity = CategoryMapper.mapCategoryResponseToEntities(input: categoryResponses)
                            // masukka ke local db
                            self.local.addCategories(from: categoryEntity) { addState in
                                switch addState {
                                case .success(let resultFromAdd):
                                    if resultFromAdd {
                                        // ambil data dari local db dan teruskan ke success utk di pake di usecase
                                        self.local.getCategories { localResponse in
                                            switch localResponse {
                                            case .success(let categoryEntity):
                                                let categoryList = CategoryMapper.mapCategoryEntityToDomains(input: categoryEntity)
                                                result(.success(categoryList))
                                            case .failure(let error):
                                                result(.failure(error))
                                            }
                                        }
                                    }
                                case .failure(let error):
                                    result(.failure(error))
                                }
                                
                            }
                        case .failure(let error):
                            result(.failure(error))
                        }
                    }
                } else { // ini kondisi awal ambil dari remote dan ada datanya, maka langsung teruskan ke success -> di pake di usecase
                    result(.success(categoryList))
                }
                
            case.failure(let error):
                result(.failure(error))
            }
        }
        
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
