//
//  CategoryMapper.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 13/08/25.
//

import Foundation

final class CategoryMapper {
    static func mapCategoryResponseToDomains(
        input categoryResponse: [CategoryResponse]
    ) -> [CategoryModel] {
        
        return categoryResponse.map { result in
            return CategoryModel(
                id: result.id ?? "",
                title: result.title ?? "Uknown",
                image: result.image ?? "Uknown",
                description: result.description ?? "Uknown"
            )
        }
    }
}
