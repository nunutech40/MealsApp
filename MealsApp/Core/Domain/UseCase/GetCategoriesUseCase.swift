//
//  GetCategoriesUseCase.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 13/08/25.
//

import Foundation
import RxSwift

protocol GetCategoriesProtocol {
    
    func getCategories() -> Observable<[CategoryModel]>
    
}

class GetCategoriesUseCase: GetCategoriesProtocol {
    
    private let repository: MealRepositoryProtocol
    
    required init(repository: MealRepositoryProtocol) {
        self.repository = repository
    }
    
    func getCategories() -> Observable<[CategoryModel]> {
        return repository.getCategories()
    }
    
}
