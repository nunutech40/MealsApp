//
//  MealsAppApp.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 11/08/25.
//

import SwiftUI
import RealmSwift
import Core
import Category

let categoryUseCase: Interactor<
  Any,
  [CategoryDomainModel],
  GetCategoriesRepository<
    GetCategoriesLocaleDataSource,
    GetCategoriesRemoteDataSource,
    CategoryTransformer>
> = Injection.init().provideCategory()


@main
struct MealsAppApp: SwiftUI.App {
    let homePresenter = CoreHomePresenter(useCase: categoryUseCase)
    let favoritePresenter = FavoritePresenter(mealFetchFavoriteUseCase: Injection.init().provideMealFetchFavoriteUseCase())
    let searchPresenter = SearchPresenter(searchUseCase: Injection.init().provideSearchMealUseCase())
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(homePresenter)
                .environmentObject(favoritePresenter)
                .environmentObject(searchPresenter)
        }
    }
}
