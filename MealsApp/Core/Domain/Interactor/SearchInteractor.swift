//
//  SearchInteractor.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 29/09/25.
//

import Foundation
import Combine

class SearchInteractor: SearchUseCase {
    
    private let repository: MealRepositoryProtocol
    
    required init(repository: MealRepositoryProtocol) {
        self.repository = repository
    }
    
    func searchMeal(by title: String) -> AnyPublisher<[MealModel], Error> {
        return repository.searchMeal(by: title)
    }
}
