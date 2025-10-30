//
//  ContentView.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 11/08/25.
//

import SwiftUI
import Category
import Core
import Home
import MealView
import FavoriteView
import SearchView

struct ContentView: View {

    @EnvironmentObject var homePresenter: HomePresenter
    
    @EnvironmentObject var favoritePresenter: FavoritePresenter
    
    @EnvironmentObject var searchPresenter: SearchMealPresenter
    
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
