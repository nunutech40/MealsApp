//
//  DetailView.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 13/08/25.
//

import SwiftUI

struct DetailView: View {
    
    @ObservedObject var presenter: DetailCategoryPresenter
    
    var body: some View {
        ZStack {
            if presenter.isLoading {
                LoadingIndicatorViewCustom()
            } else if presenter.isError {
                ErrorIndicatorView(title: presenter.errorMessage)
            }
            else {
                ScrollView(.vertical) {
                    VStack {
                        imageCategory
                        spacer
                        content
                        spacer
                    }.padding()
                }
            }
        }.onAppear {
            if self.presenter.meals.count == 0 {
                self.presenter.getMeals()
            }
        }.navigationBarTitle(Text(self.presenter.category.title), displayMode: .large)
    }
}

extension DetailView {
    var spacer: some View {
        Spacer()
    }
    
 
    
    var imageCategory: some View {
        AsyncImage(url: URL(string: self.presenter.category.image)) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }.scaledToFit().frame(width: 250.0, height: 250.0, alignment: .center)
    }
    
    var description: some View {
        Text(self.presenter.category.description)
            .font(.system(size: 15))
    }
    
    func headerTitle(_ title: String) -> some View {
        return Text(title)
            .font(.headline)
    }
    
    var mealsHorizontal: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(self.presenter.meals, id: \.id) { meal in
                    ZStack {
                        MealRow(meal: meal)
                          .frame(width: 150, height: 150)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 0) {
            if !presenter.meals.isEmpty {
                headerTitle("Meals from \(self.presenter.category.title)")
                    .padding(.bottom)
                mealsHorizontal
            }
            spacer
            headerTitle("Description")
                .padding([.top, .bottom])
            description
        }
    }
}
