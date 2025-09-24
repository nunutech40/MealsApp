//
//  ContentView.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 11/08/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var homePresenter: HomePresenter // Inject menggunakan environment object, dimana environment object ini adalah file sharing, jadi view child dibawah view parent yang memiliki EnvironmentObject bisa menggunakan ini (tinggal declare variablenya) tanpa harus di inject dari depan. (DI versi swiftui dan cuma utk view)
    
    var body: some View {
        TabView {
            NavigationStack {
                HomeView(presenter: homePresenter)
            }.tabItem {
                TabItem(imageName: "house", title: "Home")
            }
            
            NavigationStack {
                SearchView()
            }.tabItem {
                TabItem(imageName: "magnifyingglass", title: "Search")
            }
            
            NavigationStack {
                FavoriteView()
            }.tabItem {
                TabItem(imageName: "heart", title: "Favorite")
            }
        }
    }
}

#Preview {
    ContentView()
}
