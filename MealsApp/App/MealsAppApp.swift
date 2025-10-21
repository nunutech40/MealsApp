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
    
    private let injection = Injection()
    private let homeRouter = HomeRouter()
    
    private let homePresenter: HomePresenter
    private let favoritePresenter: FavoritePresenter
    private let searchPresenter: SearchPresenter
    
    init() {
        self.homePresenter = HomePresenter(
            interactor: injection.provideHomeInteractor(),
            router: homeRouter 
        )
        self.favoritePresenter = FavoritePresenter(
            mealFetchFavoriteUseCase: Injection().provideMealFetchFavoriteUseCase()
        )
        self.searchPresenter = SearchPresenter(
            searchUseCase: Injection().provideSearchMealUseCase()
        )
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(homePresenter)
                .environmentObject(favoritePresenter)
                .environmentObject(searchPresenter)
        }
    }
}
