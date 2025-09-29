//
//  SearchUseCase.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 29/09/25.
//

import Combine

protocol SearchUseCase {
    func searchMeal(by title: String) -> AnyPublisher<[MealModel], Error>
}

