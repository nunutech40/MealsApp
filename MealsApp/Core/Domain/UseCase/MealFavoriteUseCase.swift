//
//  MealFavoriteUseCase.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 25/09/25.
//


import Combine

protocol MealFavoriteUseCase {
    func updateFavoriteMeal() -> AnyPublisher<MealModel, Error>
}
