//
//  MealPresenter.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 25/09/25.
//

import Foundation
import Combine

class MealPresenter: ObservableObject {
    
    private var cancelable: Set<AnyCancellable> = []
    private let mealUseCase: MealUseCase
    private let mealUpdateFavoriteUseCase: MealUpdateFavoriteUseCase
    
    @Published var meal: MealModel
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    
    init(
        mealUseCase: MealUseCase,
        mealUpdateFavoriteUseCase: MealUpdateFavoriteUseCase
    ) {
        self.mealUseCase = mealUseCase
        self.mealUpdateFavoriteUseCase = mealUpdateFavoriteUseCase
        meal = mealUseCase.getMeal()
    }
    
    func getMeal() {
        isLoading = true
        mealUseCase.getMeal()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { meal in
                self.meal = meal
            })
            .store(in: &cancelable)
    }
    
    func updateFavoriteMeal() {
        mealUpdateFavoriteUseCase.updateFavoriteMeal()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                case .finished:
                    self.isError = false
                }
            }, receiveValue: { meal in
                self.meal = meal
            }).store(in: &cancelable)
    }
    
}
