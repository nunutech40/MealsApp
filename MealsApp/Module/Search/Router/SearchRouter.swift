//
//  SearchRouter.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 30/09/25.
//

import SwiftUI

class SearchRouter {
    
    func makeMealView(meal: MealModel) -> some View {
        let mealUseCase = Injection.init().provideMealDetailUseCase(meal: meal)
        let presenter = MealPresenter(mealUseCase: mealUseCase)
        return MealView(presenter: presenter)
    }
    
}
