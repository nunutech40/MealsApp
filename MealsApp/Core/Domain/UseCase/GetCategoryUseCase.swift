//
//  GetCategoryUseCase.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 17/09/25.
//

import Combine

protocol GetCategoryUseCase {
    
    func getCategory() -> CategoryModel
    func getMeals() -> AnyPublisher<[MealModel], Error>
    
}
