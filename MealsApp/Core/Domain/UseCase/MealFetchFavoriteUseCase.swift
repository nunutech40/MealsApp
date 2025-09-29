//
//  MealFetchFavoriteUseCase.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 29/09/25.
//

import Combine

protocol MealFetchFavoriteUseCase {
    func fetchFavoriteMeals() -> AnyPublisher<[MealModel], Error>
}
