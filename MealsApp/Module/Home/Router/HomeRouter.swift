//
//  HomeRouter.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 13/08/25.
//

import SwiftUI
import Home
import Core
import Category

public final class HomeRouter: HomeRouting {

    public init() {}

    public func makeDetailView(for category: CategoryDomainModel) -> AnyView {
        // MAP (jangan cast)
        let categoryModel = CategoryModel(
            id: category.id,
            title: category.title,
            image: category.image,
            description: category.description
        )

        let detailUseCase = Injection().provideGetCategoryDetail(category: categoryModel)
        let presenter = DetailCategoryPresenter(getCategoryUseCase: detailUseCase)

        return DetailView(presenter: presenter).eraseToAnyView()
    }
}

// helper type-erasure
public extension View {
    func eraseToAnyView() -> AnyView { AnyView(self) }
}

