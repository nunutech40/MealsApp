//
//  HomeRouter.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 13/08/25.
//

import SwiftUI

class HomeRouter {
    
    func makeDetailView(for category: CategoryModel) -> some View {
        let detailUseCase = Injection.init().provideGetCategoryDetail(category: category)
        let presenter = DetailPresenter(getCategoryUseCase: detailUseCase)
        return DetailView(presenter: presenter)
    }
}
