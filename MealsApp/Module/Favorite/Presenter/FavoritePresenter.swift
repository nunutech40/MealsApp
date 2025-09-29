//
//  FavoritePresenter.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 29/09/25.
//

import SwiftUI
import Combine

class FavoritePresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private let mealFetchFavoriteUseCase: MealFetchFavoriteUseCase
    
    @Published var meals: [MealModel] = []
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    
    init(mealFetchFavoriteUseCase: MealFetchFavoriteUseCase) {
        self.mealFetchFavoriteUseCase = mealFetchFavoriteUseCase
    }
    
    func getFavoriteMeals() {
        isLoading = true
        mealFetchFavoriteUseCase.fetchFavoriteMeals()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion{
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = false
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { meals in
                self.meals = meals
            })
            .store(in: &cancellables)
    }
}
