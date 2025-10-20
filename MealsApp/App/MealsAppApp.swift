//
//  MealsAppApp.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 11/08/25.
//

import SwiftUI
import RealmSwift
import Home


@main
struct MealsAppApp: SwiftUI.App {
    
    private let injection = Injection.init()
    
    private var homePresenter: HomePresenter {
        injection.provideHomePresenter()
    }
    
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
