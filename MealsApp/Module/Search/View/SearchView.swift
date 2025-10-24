//
//  SearchView.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 24/09/25.
//

import SwiftUI

struct SearchView: View {

    @ObservedObject var presenter: SearchPresenter
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                if presenter.isLoading {
                    LoadingIndicatorViewCustom()
                } else if presenter.title.isEmpty {
                    emptyTitle
                } else if presenter.meals.isEmpty {
                    emptyMeals
                } else if presenter.isError {
                    errorIndicator
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(
                            self.presenter.meals,
                            id: \.id
                        ) { meal in
                            ZStack {
                                SearchRow(meal: meal)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .padding(8)
                        }
                    }
                }
            }.searchable(text: $presenter.title)
                .onSubmit(of: .search, presenter.searchMeal)
            Spacer()
        }.navigationBarTitle(
            Text("Search Meals"),
            displayMode: .automatic
        )
    }
}


extension SearchView {
    
    var errorIndicator: some View {
        CustomEmptyView(
            image: "assetSearchNotFound",
            title: presenter.errorMessage
        ).offset(y: 80)
    }
    
    var emptyTitle: some View {
        CustomEmptyView(
            image: "assetSearchMeal",
            title: "Come on, find your favorite food!"
        ).offset(y: 50)
    }
    var emptyMeals: some View {
        CustomEmptyView(
            image: "assetSearchNotFound",
            title: "Data not found"
        ).offset(y: 80)
    }
    
}
