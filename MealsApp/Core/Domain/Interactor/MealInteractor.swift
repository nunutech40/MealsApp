//
//  MealInteractor.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 25/09/25.
//

import Foundation
import Combine

class MealInteractor: MealDetailUseCase {
    
    private let mealRepository: MealRepositoryProtocol
    private let meal: MealModel
    
    required init(mealRepository: MealRepositoryProtocol, meal: MealModel) {
        self.mealRepository = mealRepository
        self.meal = meal
    }
    
    func getMeal() -> AnyPublisher<MealModel, Error> {
        return mealRepository.getMeal(by: meal.id)
    }
    
    func getMeal() -> MealModel {
        return meal
    }
    
    func updateFavoriteMeal() -> AnyPublisher<MealModel, Error> {
        return mealRepository.updateFavoriteMeal(by: meal.id)
    }
}
