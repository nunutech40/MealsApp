//
//  DetailPresenter.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 13/08/25.
//

import SwiftUI

class DetailCategoryPresenter: ObservableObject {
    
    private let getCategoryUseCase: GetCategoryUseCase
    
    @Published var meals: [String] = []
    @Published var category: CategoryModel
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    @Published var isError: Bool = false
    
    init(getCategoryUseCase: GetCategoryUseCase) {
        self.getCategoryUseCase = getCategoryUseCase
        self.category = getCategoryUseCase.getCategory()
    }
    
}
