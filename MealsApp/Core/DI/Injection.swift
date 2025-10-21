//
//  Injection.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 13/08/25.
//

import Foundation
import RealmSwift
import UIKit
import Core
import Category
import Meal
import Home

final class Injection: NSObject {
    
    private let realm = try? Realm()
    
    typealias GetCategoriesUseCase = Interactor<
        Any,
        [CategoryDomainModel],
        GetCategoriesRepository<GetCategoriesLocaleDataSource, GetCategoriesRemoteDataSource, CategoryTransformer>
    >
    
    typealias GetRandomMealUseCase = Interactor<
        Any,
        MealDomainModel,
        GetRandomMealRepository<GetRandomMealRemoteDataSource, MealTransformer>
    >
    
    func provideRepository() -> MealRepositoryProtocol {
        let realm = try? Realm()
        
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        let locale: LocalDataSource = LocalDataSource.sharedInstance(realm)
        
        return MealRepository.sharedInstance(remote, locale)
    }
    
    func provideGetCategoriesUseCase() -> GetCategoriesUseCase {
        
        let locale = GetCategoriesLocaleDataSource(realm: realm!)
        let remote = GetCategoriesRemoteDataSource(endpoint: EndPoints.Gets.categories.url)
        let mapper = CategoryTransformer()
        
        let repository = GetCategoriesRepository(
            localeDataSource: locale,
            remoteDataSource: remote,
            mapper: mapper
        )
        
        return Interactor(repository: repository)
    }
    
    func provideGetRandomMealUseCase() -> GetRandomMealUseCase {
        let remote = GetRandomMealRemoteDataSource(endpoint: EndPoints.Gets.random.url)
        let mapper = MealTransformer()
        
        let repository = GetRandomMealRepository(
            remoteDataSource: remote,
            mapper: mapper
        )
        return Interactor(repository: repository)
    }
    
    func provideHomeInteractor() -> HomeInteractorProtocol {
        
        // Ambil 'use case' granular yang sudah jadi
        let categoriesUseCase = provideGetCategoriesUseCase()
        let randomMealUseCase = provideGetRandomMealUseCase()
        
        // Rakit 'HomeInteractor'-nya
        return HomeInteractor(
            getCategoriesUseCase: categoriesUseCase,
            getRandomMealUseCase: randomMealUseCase
        )
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
