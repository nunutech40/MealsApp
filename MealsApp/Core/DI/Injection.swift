//
//  Injection.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 13/08/25.
//

import Foundation
import RealmSwift
import Core
import Category
import UIKit
import Meal

final class Injection: NSObject {
    
    private let realm = try? Realm()
    
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
    
    // provide category from module category
    // Inject dari package local
    func provideCategory<U: UseCase>() -> U where U.Request == Any, U.Response == [CategoryDomainModel] {
        
        let locale = GetCategoriesLocaleDataSource(realm: realm!)
        
        let remote = GetCategoriesRemoteDataSource(endpoint: EndPoints.Gets.categories.url)
        
        let mapper = CategoryTransformer()
        
        
        let repository = GetCategoriesRepository(
            localeDataSource: locale,
            remoteDataSource: remote,
            mapper: mapper
        )
        
        return Interactor(repository: repository) as! U
    }
    
    func provideRandomMeal<U: UseCase>() -> U where U.Request == Any, U.Response == MealDomainModel {
        let remote = GetRandomMealRemoteDataSource(endpoint: EndPoints.Gets.random.url)
        
        let mapper = MealTransformer()
        
        let repository = GetRandomMealRepository(
            remoteDataSource: remote,
            mapper: mapper
        )
        return Interactor(repository: repository) as! U
    }
    
    func provideGetCategoryDetail(category: CategoryModel) -> GetCategoryUseCase {
        let repository: MealRepositoryProtocol = provideRepository()
        return DetailCategoryInteractor(repository: repository, category: category)
    }
    
    // Hanya butuh SATU provider yang mengembalikan TIPE KONKRET-nya
    func provideMealDetailUseCase(meal: MealModel) -> MealDetailUseCase {
        let repository = provideRepository()
        return MealInteractor(mealRepository: repository, meal: meal)
    }
    
    func provideMealFetchFavoriteUseCase() -> MealFetchFavoriteUseCase {
        let repository: MealRepositoryProtocol = provideRepository()
        
        return MealFavoriteInteractor(repository: repository)
    }
    
    func provideSearchMealUseCase() -> SearchUseCase {
        let repository = provideRepository()
        return SearchInteractor(repository: repository)
    }
    
}
