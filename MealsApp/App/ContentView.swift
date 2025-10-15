//
//  ContentView.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 11/08/25.
//

import SwiftUI
import Category
import Core

struct ContentView: View {

    @EnvironmentObject var homePresenter: CoreHomePresenter<Any, CategoryDomainModel, Interactor<Any, [CategoryDomainModel], GetCategoriesRepository<GetCategoriesLocaleDataSource, GetCategoriesRemoteDataSource, CategoryTransformer>>>
    
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
            
            NavigationStack {
                AboutMeView()
            }.tabItem {
                TabItem(imageName: "person.crop.circle", title: "About Me")
            }
        }
    }
}

#Preview {
    ContentView()
}
