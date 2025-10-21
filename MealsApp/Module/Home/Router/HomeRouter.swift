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

public final class HomeRouter: HomeRouting {
    
    public func makeMealView(for meal: MealDomainModel) -> AnyView {
        // MAP (jangan cast)
        let mealModel = MealModel(
            id: meal.id,
            title: meal.title,
            image: meal.image,
            category: meal.category,
            area: meal.area,
            instructions: meal.instructions,
            tag: meal.tag,
            youtube: meal.youtube,
            source: meal.source,
            ingredients: meal.ingredients.map { dom in
                IngredientModel(id: dom.id, title: dom.title, idMeal: dom.idMeal)
            },
            favorite: meal.favorite
        )
        
        let mealUsecase = Injection.init().provideMealDetailUseCase(meal: mealModel)
        
        let presenter = MealPresenter(mealUseCase: mealUsecase)
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

