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

public final class HomeRouter: HomeRouting {
    
    public func makeMealView(for meal: MealDomainModel) -> AnyView {
        print("cek data meal in \(meal)")
        // 1) Ambil use case by-id dari Injection
        let uc = Injection().provideGetMealByIdUseCase(meal: meal)
        
        // 2) Rakit interactor pakai domain model (seed) + use case
        let interactor = MealInteractor(mealModel: meal, mealUseCase: uc)
        
        // 3) Rakit presenter sesuai init aslinya
        let presenter = MealPresenter(interactor: interactor, meal: meal)
        
        // 4) Bangun view
        return MealView(presenter: presenter).eraseToAnyView()
    }
    
    public init() {}
    
    public func makeDetailView(for category: CategoryDomainModel) -> AnyView {
        // MAP (jangan cast)
        let categoryModel = CategoryModel(
            id: category.id,
            title: category.title,
            image: category.image,
            description: category.description
        )
        
        let detailUseCase = Injection().provideGetCategoryDetail(category: categoryModel)
        let presenter = DetailCategoryPresenter(getCategoryUseCase: detailUseCase)
        
        return DetailView(presenter: presenter).eraseToAnyView()
    }
}

// helper type-erasure
public extension View {
    func eraseToAnyView() -> AnyView { AnyView(self) }
}

