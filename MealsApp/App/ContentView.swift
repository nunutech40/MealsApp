//
//  ContentView.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 11/08/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var homePresenter: HomePresenter
    
    var body: some View {
        NavigationStack {
            HomeView(presenter: homePresenter)
        }
    }
}

#Preview {
    ContentView()
}
