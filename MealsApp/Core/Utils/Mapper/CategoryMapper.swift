//
//  CategoryMapper.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 13/08/25.
//

import Foundation

final class CategoryMapper {
    
    static func mapCategoryResponseToEntities(
        input categoryResponses: [CategoryResponse]
    ) -> [CategoryEntity] {
        return categoryResponses.map { result in
            let newCategory = CategoryEntity()
            newCategory.id = result.id ?? ""
            newCategory.title = result.title ?? ""
            newCategory.image = result.image ?? ""
            newCategory.desc = result.description ?? ""
            return newCategory
        }
    }
    
    static func mapCategoryEntityToDomains(
        input categoryEntity: [CategoryEntity]
    ) -> [CategoryModel] {
        return categoryEntity.map { result in
            CategoryModel(
                id: result.id,
                title: result.title,
                image: result.image,
                description: result.desc
            )
        }
    }
    
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
