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
        let realm = try? Realm()
        
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        let locale: LocalDataSource = LocalDataSource.sharedInstance(realm)
        
        return MealRepository.sharedInstance(remote, locale)
    }
    
    
    // Provide UseCase
    func provideGetCategories() -> GetCategoriesUseCase {
        let repository: MealRepositoryProtocol = provideRepository()
        
        return HomeInteractor(repository: repository)
    }
    
    func provideGetCategoryDetail(category: CategoryModel) -> GetCategoryUseCase {
        let repository: MealRepositoryProtocol = provideRepository()
        return DetailCategoryInteractor(repository: repository, category: category)
    }
    
    func provideMealUseCase(meal: MealModel) -> MealUseCase {
        let repository = provideRepository()
        return MealInteractor(mealRepository: repository, meal: meal)
    }
    
    func provideMealUpdateFavoriteUseCase(meal: MealModel) -> MealUpdateFavoriteUseCase {
        let repository = provideRepository()
        return MealInteractor(mealRepository: repository, meal: meal)
    }
    
    func provideMealFetchFavoriteUseCase() -> MealFetchFavoriteUseCase {
        let repository: MealRepositoryProtocol = provideRepository()
        
        return MealFavoriteInteractor(repository: repository)
    }
    
}
