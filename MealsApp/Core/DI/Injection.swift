//
//  Injection.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 13/08/25.
//

import Foundation

final class Injection: NSObject {
    
    // Provide Repository
    private func provideRepository() -> MealRepositoryProtocol {
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        
        return MealRepository.sharedInstance(remote)
    }
    
    
    // Provide UseCase
    private func provideGetCategories() -> GetCategoriesProtocol {
        let repository: MealRepositoryProtocol = provideRepository()
        
        return GetCategoriesUseCase(repository: repository)
    }
    
    func provideGetCategoryDetail(category: CategoryModel) -> GetCategoryProtocol {
        let repository: MealRepositoryProtocol = provideRepository()
        return GetCategoryUseCase(repository: repository, category: category)
    }
    
}
