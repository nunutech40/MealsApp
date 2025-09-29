//
//  FavoriteRouter.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 29/09/25.
//


import SwiftUI

class FavoriteRouter {
    
    func makeMealView(for meal: MealModel) -> some View {
        let mealUsecase = Injection.init().provideMealUseCase(meal: meal)
        let mealUpdateFavoriteMeal = Injection.init().provideMealUpdateFavoriteUseCase(meal: meal)
        let presenter = MealPresenter(mealUseCase: mealUsecase, mealUpdateFavoriteUseCase: mealUpdateFavoriteMeal)
        return MealView(presenter: presenter)
    }
    
}
