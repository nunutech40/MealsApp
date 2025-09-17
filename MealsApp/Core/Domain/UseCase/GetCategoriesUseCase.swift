//
//  GetCategoriesUseCase.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 17/09/25.
//

import Combine

protocol GetCategoriesUseCase {
    
    func getCategories() -> AnyPublisher<[CategoryModel], Error>
    
}
