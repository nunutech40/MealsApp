//
//  FavoriteRouter.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 29/09/25.
//

import SwiftUI
import Home
import Core
import MealView
import FavoriteView
import Common

public final class FavoriteRouter: FavoriteRouting {
    
    public init() {}
    
    public func makeMealView(for meal: MealDomainModel) -> AnyView {
        // 1) Ambil use case by-id dari Injection
        let uc = Injection().provideGetMealByIdUseCase(meal: meal)
        let updateUC = Injection().provideUpdateFavoriteMealUseCase(meal: meal)
        
        // 2) Rakit interactor pakai domain model (seed) + use case
        let interactor = MealInteractor(mealModel: meal, mealUseCase: uc, updateFavoriteUseCase: updateUC)
        
        // 3) Rakit presenter sesuai init aslinya
        let presenter = MealPresenter(interactor: interactor)
        
        // 4) Bangun view
        return MealView(presenter: presenter).eraseToAnyView()
    }
    
}

