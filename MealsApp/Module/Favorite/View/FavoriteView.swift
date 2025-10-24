//
//  FavoriteView.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 24/09/25.
//

import SwiftUI

struct FavoriteView: View {
   
    @ObservedObject var presenter: FavoritePresenter
    
    var body: some View {
        ZStack {
            if presenter.isLoading {
                LoadingIndicatorViewCustom()
            } else if presenter.isError {
                ErrorIndicatorView(title: "Load Favorite Error")
            } else if presenter.meals.count == 0 {
                emptyFavorites
            } else {
                content
            }
        }.onAppear {
            self.presenter.getFavoriteMeals()
        }.navigationBarTitle(
            Text("Favorite Meals"),
            displayMode: .automatic
        )
    }
    
    
}

extension FavoriteView {
    var emptyFavorites: some View {
        CustomEmptyView(
            image: "assetNoFavorite",
            title: "Your favorite is empty"
        ).offset(y: 80)
    }
    
    var content: some View {
        ScrollView(
            .vertical,
            showsIndicators: false
        ) {
            ForEach(
                self.presenter.meals,
                id: \.id
            ) { meal in
                ZStack {
                    FavoriteRow(meal: meal)
                }.buttonStyle(PlainButtonStyle())
            }
        }
    }
}
