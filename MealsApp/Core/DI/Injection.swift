//
//  Injection.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 13/08/25.
//

import Foundation
import RealmSwift

final class Injection: NSObject {
    
    // Provide Repository
    func provideRepository() -> MealRepositoryProtocol {
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        
        let realm = try? Realm()
        let locale: LocalDataSource = LocalDataSource.sharedInstance(realm)
        
        return MealRepository.sharedInstance(remote, locale)
    }
    
    
    // Provide UseCase
    func provideGetCategories() -> GetCategoriesProtocol {
        let repository: MealRepositoryProtocol = provideRepository()
        
        return GetCategoriesUseCase(repository: repository)
    }
    
    func provideGetCategoryDetail(category: CategoryModel) -> GetCategoryProtocol {
        let repository: MealRepositoryProtocol = provideRepository()
        return GetCategoryUseCase(repository: repository, category: category)
    }
    
}
