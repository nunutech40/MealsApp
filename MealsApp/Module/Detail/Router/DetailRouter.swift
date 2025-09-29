//
//  MealRouter.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 25/09/25.
//

import SwiftUI

class DetailRouter {
    func makeMealView(for meal: MealModel) -> some View {
        let mealUseCase = Injection.init().provideMealUseCase(meal: meal)
        let mealUpdateFavroiteUseCase = Injection.init().provideMealUpdateFavoriteUseCase(meal: meal)
        let presenter = MealPresenter(mealUseCase: mealUseCase, mealUpdateFavoriteUseCase: mealUpdateFavroiteUseCase)
        return MealView(presenter: presenter)
    }
}
