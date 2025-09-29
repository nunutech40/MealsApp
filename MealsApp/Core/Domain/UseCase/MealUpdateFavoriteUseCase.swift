//
//  MealFavoriteUseCase.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 25/09/25.
//


import Combine

protocol MealUpdateFavoriteUseCase {
    func updateFavoriteMeal() -> AnyPublisher<MealModel, Error>
}
