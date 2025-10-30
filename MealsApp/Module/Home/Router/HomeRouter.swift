//
//  HomeRouter.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 13/08/25.
//

import SwiftUI
import Home
import Core
import Category
import MealView
import Common

public final class HomeRouter: HomeRouting {
    
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
    
    public init() {}
    
    public func makeDetailView(for category: CategoryDomainModel) -> AnyView {
      
        // 1) Ambil use case by-id dari Injection
        let uc = Injection().provideGetMealsByCategoryUseCase(category: category)
        // 2) Rakit interactor pakai domain model (seed) + use case
        let interactor = DetailCategoryInteractor(category: category, mealUseCase: uc)
        
        let router = DetailCategoryRouter()
        // 3) Rakit presenter sesuai init aslinya
        let presenter = DetailCategoryPresenter(interactor: interactor, router: router)
        
        
        return DetailView(presenter: presenter).eraseToAnyView()
    }
}
