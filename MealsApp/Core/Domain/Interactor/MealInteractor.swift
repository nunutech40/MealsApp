//
//  MealInteractor.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 25/09/25.
//

import Foundation
import Combine

class MealInteractor: MealUseCase { //MealFavoriteUseCase
    
    private let mealRepository: MealRepository
    private let meal: MealModel
    
    required init(mealRepository: MealRepository, meal: MealModel) {
        self.mealRepository = mealRepository
        self.meal = meal
    }
    
    func getMeal() -> AnyPublisher<MealModel, Error> {
        return mealRepository.getMeal(by: meal.id)
    }
    
    func getMeal() -> MealModel {
        return meal
    }
}
