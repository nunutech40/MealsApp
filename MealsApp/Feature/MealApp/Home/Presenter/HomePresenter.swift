//
//  HomePresenter.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 13/08/25.
//

import SwiftUI
import Combine

class HomePresenter: ObservableObject {
    
    private let router = HomeRouter()
    private let getCategoriesUseCase: GetCategoriesProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    @Published var categories: [CategoryModel] = []
    
    init(getCategoriesUseCase: GetCategoriesProtocol) {
        self.getCategoriesUseCase = getCategoriesUseCase
    }
    
    func getCategories() {
        loadingState = true
        
        getCategoriesUseCase.getCategories()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { categories in
                self.categories = categories
            })
            .store(in: &cancellables)
        
    }
    
    func linkBuilder<Content: View>(
        for category: CategoryModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: router.makeDetailView(for: category)) {
                content()
            }
    }
}
