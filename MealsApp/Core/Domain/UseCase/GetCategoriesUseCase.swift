//
//  GetCategoriesUseCase.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 13/08/25.
//

import Foundation
import Combine

protocol GetCategoriesProtocol {
    
    func getCategories() -> AnyPublisher<[CategoryModel], Error>
    
}

class GetCategoriesUseCase: GetCategoriesProtocol {
    
    private let repository: MealRepositoryProtocol
    
    required init(repository: MealRepositoryProtocol) {
        self.repository = repository
    }
    
    func getCategories() -> AnyPublisher<[CategoryModel], Error> {
        return repository.getCategories()
    }
    
}
