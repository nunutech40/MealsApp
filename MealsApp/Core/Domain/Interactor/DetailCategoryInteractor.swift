//
//  GetCategoryUseCase.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 13/08/25.
//

import Foundation
import Combine

class DetailCategoryInteractor: GetCategoryUseCase {
    
    private let repository: MealRepositoryProtocol
    private let category: CategoryModel
    
    required init(repository: MealRepositoryProtocol, category: CategoryModel) {
        self.repository = repository
        self.category = category
    }
    
    func getCategory() -> CategoryModel {
        return category
    }
    
    func getMeals() -> AnyPublisher<[MealModel], Error> {
        return repository.getMeals(by: category.title)
    }
    
}
