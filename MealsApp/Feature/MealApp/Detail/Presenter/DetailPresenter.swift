//
//  DetailPresenter.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 13/08/25.
//

import SwiftUI

class DetailPresenter: ObservableObject {
    
    private let getCategoryUseCase: GetCategoryProtocol
    
    @Published var category: CategoryModel
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(getCategoryUseCase: GetCategoryProtocol) {
        self.getCategoryUseCase = getCategoryUseCase
        self.category = getCategoryUseCase.getCategory()
    }
    
}
