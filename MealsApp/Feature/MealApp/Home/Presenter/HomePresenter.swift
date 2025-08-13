//
//  HomePresenter.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 13/08/25.
//

import SwiftUI

class HomePresenter: ObservableObject {
    
    private let router = HomeRouter()
    private let getCategoriesUseCase: GetCategoriesProtocol
    
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    @Published var categories: [CategoryModel] = []
    
    init(getCategoriesUseCase: GetCategoriesProtocol) {
        self.getCategoriesUseCase = getCategoriesUseCase
    }
    
    func getCategories() {
        loadingState = true
        getCategoriesUseCase.getCategories { result in
            switch result {
            case .success(let categories):
                DispatchQueue.main.async {
                    self.loadingState = false
                    self.categories = categories
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.loadingState = false
                    self.errorMessage = error.localizedDescription
                }
            }
            
        }
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
