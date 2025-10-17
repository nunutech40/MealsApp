//
//  FavoriteRouter.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 29/09/25.
//


import SwiftUI

class FavoriteRouter {
    
    func makeMealView(for meal: MealModel) -> some View {
        let mealUsecase = Injection.init().provideMealDetailUseCase(meal: meal)
        
        let presenter = MealPresenter(mealUseCase: mealUsecase)
        return MealView(presenter: presenter)
    }
    
}
