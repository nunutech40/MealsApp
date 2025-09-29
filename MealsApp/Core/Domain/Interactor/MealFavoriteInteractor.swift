//
//  MealFavoriteInteractor.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 29/09/25.
//

import Combine

class MealFavoriteInteractor: MealFetchFavoriteUseCase {
    
    private let repository: MealRepositoryProtocol
    
    required init(repository: MealRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchFavoriteMeals() -> AnyPublisher<[MealModel], Error> {
        return repository.getFavoriteMeals()
    }
    
}
