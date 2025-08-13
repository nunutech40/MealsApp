//
//  GetCategoriesUseCase.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 13/08/25.
//

import Foundation

protocol GetCategoriesProtocol {
    
    func getCategories(completion: @escaping (Result<[CategoryModel], Error>) -> Void)
    
}

class GetCategoriesUseCase: GetCategoriesProtocol {
    
    private let repository: MealRepositoryProtocol
    
    required init(repository: MealRepositoryProtocol) {
        self.repository = repository
    }
    
    func getCategories(completion: @escaping (Result<[CategoryModel], any Error>) -> Void) {
        repository.getCategories { result in
            completion(result)
        }
    }
    
}
