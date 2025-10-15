//
//  GetCategoriesUseCase.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 13/08/25.
//

import Foundation
import Combine

class HomeInteractor: GetCategoriesUseCase, RandomMealUseCase {
    
    private let repository: MealRepositoryProtocol
    
    required init(repository: MealRepositoryProtocol) {
        self.repository = repository
    }
    
    func getCategories() -> AnyPublisher<[CategoryModel], Error> {
        return repository.getCategories()
    }
    
    func randoomMeal() -> AnyPublisher<MealModel, any Error> {
        return repository.getRandomMeal()
    }
    
}
