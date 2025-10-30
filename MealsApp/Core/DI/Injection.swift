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
import MealView
import FavoriteView
import SearchView

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
        GetRandomMealRepository<GetMealRemoteDataSource, MealTransformer>
    >
    
    // Tambah typealias
    typealias GetMealByIdUseCase = Interactor<
        Any,
        MealDomainModel,
        GetMealByIdRepository<MealLocalDataSource, GetMealRemoteDataSource, MealTransformer>
    >
    
    // Tambah typealias
    typealias GetMealsByCategoryUseCase = Interactor<
        Any,
        [MealDomainModel],
        GetMealsByCategoryRepository<MealLocalDataSource, GetMealsRemoteDataSource, MealsTransformer>
    >
    
    // Tambah typealias
    typealias UpdateFavoriteMealUseCase = Interactor<
        Any,
        MealDomainModel,
        UpdateFavoriteMealRepository<UpdateFavoriteMealLocalDataSource, MealTransformer>
    >
    
    // Tambah typealias
    typealias GetFavoriteMealsUseCase = Interactor<
        Any,
        [MealDomainModel],
        GetFavoriteMealsRepository<ListFavoriteMealLocalDataSource, MealsTransformer>
    >
    
    
    // Tambah typealias
    typealias SearchMealsUseCase = Interactor<
        Any,
        [MealDomainModel],
        SearchMealsRepository<SearchMealsLocalDataSource, SearchMealsRemoteDataSource, MealsTransformer>
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
        let remote = GetMealRemoteDataSource(endpoint: EndPoints.Gets.random.url)
        let mapper = MealTransformer()
        
        let repository = GetRandomMealRepository(
            remoteDataSource: remote,
            mapper: mapper
        )
        return Interactor(repository: repository)
    }
    
    func provideGetMealByIdUseCase(meal: MealDomainModel) -> GetMealByIdUseCase {
        let locale = MealLocalDataSource(realm: realm!) // realm sudah disimpan di Injection
        let remote = GetMealRemoteDataSource(endpoint: EndPoints.Gets.meal(id: meal.id).url)
        let mapper = MealTransformer()
        let repo = GetMealByIdRepository(localeDataSource: locale, remoteDataSource: remote, mapper: mapper)
        return Interactor(repository: repo)
    }
    
    func provideUpdateFavoriteMealUseCase(meal: MealDomainModel) -> UpdateFavoriteMealUseCase {
        let locale = UpdateFavoriteMealLocalDataSource(realm: realm!) // realm sudah disimpan di Injection
        let mapper = MealTransformer()
        let repo = UpdateFavoriteMealRepository(localeDataSource: locale, mapper: mapper)
        return Interactor(repository: repo)
    }
    
    func provideGetMealsByCategoryUseCase(category: CategoryDomainModel) -> GetMealsByCategoryUseCase {
        
        let locale = MealLocalDataSource(realm: realm!) // realm sudah disimpan di Injection
        let remote = GetMealsRemoteDataSource(endpoint: EndPoints.Gets.meals(category: category.title).url)
        let mapper = MealsTransformer()
        let repo = GetMealsByCategoryRepository(localeDataSource: locale, remoteDataSource: remote, mapper: mapper)
        return Interactor(repository: repo)
    }
    
    func provideGetFavoriteMealsUseCase() -> GetFavoriteMealsUseCase {
        let locale = ListFavoriteMealLocalDataSource(realm: realm!) // realm sudah disimpan di Injection
        let mapper = MealsTransformer()
        let repo = GetFavoriteMealsRepository(localeDataSource: locale, mapper: mapper)
        return Interactor(repository: repo)
    }
    
    func provideSearchMealsUseCase() -> SearchMealsUseCase {
        let locale = SearchMealsLocalDataSource(realm: realm!)
        let remote = SearchMealsRemoteDataSource()
        let mapper = MealsTransformer()
        let repo = SearchMealsRepository(localeDataSource: locale, remoteDataSource: remote, mapper: mapper)
        return Interactor(repository: repo)
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
    
    func provideMealInteractor(meal: MealDomainModel) -> MealInteractorProtocol {
        let uc = provideGetMealByIdUseCase(meal: meal)
        let updateUseCase = provideUpdateFavoriteMealUseCase(meal: meal)
        return MealInteractor(mealModel: meal, mealUseCase: uc, updateFavoriteUseCase: updateUseCase)
    }
    
    func provideFavoriteMealsInteractor() -> FavoriteInteractorProtocol {
        let uc = provideGetFavoriteMealsUseCase()
        return FavoriteInteractor(favoriteMealsUseCase: uc)
    }
    
    func provideSearchMealsInteractor() -> SearchMealInteractorProtocol {
        let uc = provideSearchMealsUseCase()
        return SearchMealInteractor(searchMealUseCase: uc)
    }
    
}
