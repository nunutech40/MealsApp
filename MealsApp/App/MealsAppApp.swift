//
//  MealsAppApp.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 11/08/25.
//

import SwiftUI

@main
struct MealsAppApp: App {
    let homePresenter = HomePresenter(getCategoriesUseCase: Injection.init().provideGetCategories())
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
