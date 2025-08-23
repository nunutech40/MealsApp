//
//  MealRepository.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 13/08/25.
//

import Foundation
import RxSwift

protocol MealRepositoryProtocol {
    
    func getCategories() -> Observable<[CategoryModel]>
    
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
    
    func getCategories() -> Observable<[CategoryModel]> {
        return self.local.getCategories() // get categories dari localdb
            .map { CategoryMapper.mapCategoryEntityToDomains(input: $0) }
            .filter { !$0.isEmpty }  // cek jika kosong, ambil data dari remote jika tidak kosong result teruskan ke success (masuk ke usecase)
            .ifEmpty(switchTo: self.remote.getCategories() // ambil dari remote karena kosong
                .map { CategoryMapper.mapCategoryResponseToEntities(input: $0) }
                .flatMap { self.local.addCategories(from: $0) } // after ambil dari remote, save ke local categories
                .filter { $0 }
                .flatMap { _ in self.local.getCategories() // ambil dari local categories dan map ke model
                        .map { CategoryMapper.mapCategoryEntityToDomains(input: $0) }
                }
            )
    }
    
}
