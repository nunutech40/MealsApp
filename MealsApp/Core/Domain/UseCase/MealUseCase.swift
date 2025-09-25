//
//  MealUseCase.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 25/09/25.
//

import Combine

protocol MealUseCase {
    func getMeal() -> AnyPublisher<MealModel, Error>
    func getMeal() -> MealModel
}
