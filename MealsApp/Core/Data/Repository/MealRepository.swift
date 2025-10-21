//
//  MealRepository.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 13/08/25.
//

import Foundation
import Combine

protocol MealRepositoryProtocol {
    
    func getCategories() -> AnyPublisher<[CategoryModel], Error>
    func getMeals(by category: String) -> AnyPublisher<[MealModel], Error>
    
    func getMeal(by idMeal: String) -> AnyPublisher<MealModel, Error>
    
    func getRandomMeal() -> AnyPublisher<MealModel, Error>
    
    // favorites
    func getFavoriteMeals() -> AnyPublisher<[MealModel], Error>
    func updateFavoriteMeal(by idMeal: String) -> AnyPublisher<MealModel, Error>
    
    // search
    func searchMeal(by title: String) -> AnyPublisher<[MealModel], Error>
    
}

final class MealRepository: NSObject {
    
    typealias MealInstance = (RemoteDataSource, LocalDataSource) -> MealRepository
    
    fileprivate let remote: RemoteDataSource
    fileprivate let local: LocalDataSource
    
    private init(remote: RemoteDataSource, local: LocalDataSource) {
        self.remote = remote
        self.local = local
    }
    
    static let sharedInstance: MealInstance = { remoteRepo, localRepo in
        return MealRepository(remote: remoteRepo, local: localRepo)
    }
    
}

extension MealRepository: MealRepositoryProtocol {
    
    func getCategories() -> AnyPublisher<[CategoryModel], Error> {
        return self.local.getCategories()
            .flatMap { result -> AnyPublisher<[CategoryModel], Error> in
                if result.isEmpty {
                    return self.remote.getCategories()
                        .map { CategoryMapper.mapCategoryResponsesToEntities(input: $0) }
                        .catch { _ in self.local.getCategories() }
                        .flatMap { self.local.addCategories(from: $0) }
                        .filter { $0 }
                        .flatMap { _ in self.local.getCategories()
                                .map { CategoryMapper.mapCategoryEntitiesToDomains(input: $0) }
                        }.eraseToAnyPublisher()
                    
                } else {
                    
                    return Just(result)
                        .setFailureType(to: Error.self)
                        .map { CategoryMapper.mapCategoryEntitiesToDomains(input: $0) }
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
        
    }
    
    func getMeals(
        by category: String
    ) -> AnyPublisher<[MealModel], Error> {
        return self.local.getMeals(by: category)
            .flatMap { result -> AnyPublisher<[MealModel], Error> in
                if result.isEmpty {
                    return self.remote.getMeals(by: category)
                        .map { MealMapper.mapMealResponsesToEntities(by: category, input: $0) }
                        .catch { _ in self.local.getMeals(by: category) }
                        .flatMap { self.local.addMeals(by: category, from: $0) }
                        .filter { $0 }
                        .flatMap { _ in self.local.getMeals(by: category)
                                .map {  MealMapper.mapMealEntitiesToDomains(input: $0) }
                        }.eraseToAnyPublisher()
                } else {
                    return Just(result)
                        .setFailureType(to: Error.self)
                        .map { MealMapper.mapMealEntitiesToDomains(input: $0) }
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
    
    func getMeal(by idMeal: String) -> AnyPublisher<MealModel, Error> {
        return self.local.getMeal(by: idMeal)
            .flatMap { result -> AnyPublisher<MealModel, Error> in
                if result.ingredients.isEmpty {
                    return self.remote.getMeal(by: idMeal)
                        .map { MealMapper.mapDetailMealResponseToEntity(by: idMeal, input: $0) }
                        .catch { _ in
                            self.local.getMeal(by: idMeal)
                        }
                        .flatMap { self.local.updateMeal(by: idMeal, meal: $0) }
                        .filter { $0 }
                        .flatMap { _ in self.local.getMeal(by: idMeal)
                                .map { MealMapper.mapDetailMealEntityToDomain(input: $0) }
                        }.eraseToAnyPublisher()
                } else {
                    // ⬇️ pakai result yang sudah ada, jangan query ulang
                    return Just(result)
                        .setFailureType(to: Error.self)
                        .map { MealMapper.mapDetailMealEntityToDomain(input: $0) }
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
    
    func getRandomMeal() -> AnyPublisher<MealModel, Error> {
        return self.remote.getRandomMeal()
            .map {
                MealMapper.mapDetailMealResponseToDomain(input: $0)
            }
            .eraseToAnyPublisher()
    }
    
    func getFavoriteMeals() -> AnyPublisher<[MealModel], any Error> {
        return self.local.getFavoritesMeals()
            .map { MealMapper.mapMealEntitiesToDomains(input: $0) }
            .eraseToAnyPublisher()
    }
    
    func updateFavoriteMeal(by idMeal: String) -> AnyPublisher<MealModel, Error> {
        return self.local.updateFavoriteMeal(by: idMeal)
            .map {
                MealMapper.mapDetailMealEntityToDomain(input: $0)
            }
            .eraseToAnyPublisher()
    }
    
    func searchMeal(
        by title: String
    ) -> AnyPublisher<[MealModel], Error> {
        return self.remote.searchMeal(by: title)
            .map { MealMapper.mapDetailMealResponseToEntity(input: $0) }
            .catch { _ in self.local.getMealsBy(title) }
            .flatMap { responses  in
                self.local.getMealsBy(title)
                    .flatMap { local -> AnyPublisher<[MealModel], Error> in
                        if responses.count > local.count {
                            return self.local.addMealsBy(title, from: responses)
                                .filter { $0 }
                                .flatMap { _ in self.local.getMealsBy(title)
                                        .map { MealMapper.mapDetailMealEntityToDomains(input: $0) }
                                }.eraseToAnyPublisher()
                        } else {
                            return self.local.getMealsBy(title)
                                .map { MealMapper.mapDetailMealEntityToDomains(input: $0) }
                                .eraseToAnyPublisher()
                        }
                    }
            }.eraseToAnyPublisher()
    }
}
