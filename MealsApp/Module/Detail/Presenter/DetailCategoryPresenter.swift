//
//  DetailPresenter.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 13/08/25.
//

import SwiftUI
import Combine

class DetailCategoryPresenter: ObservableObject {
    
    private var cancellable: Set<AnyCancellable> = []
    private let getCategoryUseCase: GetCategoryUseCase
    private let router = DetailRouter()
    
    @Published var meals: [MealModel] = []
    @Published var category: CategoryModel
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    
    init(getCategoryUseCase: GetCategoryUseCase) {
        self.getCategoryUseCase = getCategoryUseCase
        self.category = getCategoryUseCase.getCategory()
    }
    
    func getMeals() {
        isLoading = true
        getCategoryUseCase.getMeals()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.isError = false
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { meals in
                self.meals = meals
            })
            .store(in: &cancellable)
    }
    
//    func linkBuilder<Content: View>(
//      for meal: MealModel,
//      @ViewBuilder content: () -> Content
//    ) -> some View {
//      NavigationLink(destination: router.makeMealView(for: meal)) { content() }
//    }
}
