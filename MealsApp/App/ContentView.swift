//
//  ContentView.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 11/08/25.
//

import SwiftUI
import Core
import Category

struct ContentView: View {

    @EnvironmentObject var homePresenter: GetListPresenter<Any, CategoryDomainModel, Interactor<Any, [CategoryDomainModel], GetCategoriesRepository<GetCategoriesLocaleDataSource, GetCategoriesRemoteDataSource, CategoryTransformer>>>
    
    @EnvironmentObject var favoritePresenter: FavoritePresenter
    
    @EnvironmentObject var mealPresenter: MealPresenter
    
    @EnvironmentObject var searchPresenter: SearchPresenter
    
    var body: some View {
        TabView {
            NavigationStack {
                HomeView(presenter: homePresenter)
            }.tabItem {
                TabItem(imageName: "house", title: "Home")
            }
            
            NavigationStack {
                SearchView(presenter: searchPresenter)
            }.tabItem {
                TabItem(imageName: "magnifyingglass", title: "Search")
            }
            
            NavigationStack {
                FavoriteView(presenter: favoritePresenter)
            }.tabItem {
                TabItem(imageName: "heart", title: "Favorite")
            }
        }
    }
}

#Preview {
    ContentView()
}
