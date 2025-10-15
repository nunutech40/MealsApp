//
//  RandomMealUseCase.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 14/10/25.
//

import Combine

protocol RandomMealUseCase {
    func randoomMeal() -> AnyPublisher<MealModel, Error>
}
