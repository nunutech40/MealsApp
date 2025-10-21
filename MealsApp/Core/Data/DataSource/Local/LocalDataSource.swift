//
//  LocalDataSource.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 16/08/25.
//

import Foundation
import RealmSwift
import Combine

protocol LocalDataSourceProtocol: AnyObject {
    
    // Categories
    func getCategories() -> AnyPublisher<[CategoryEntity], Error>
    func addCategories(from categories: [CategoryEntity]) -> AnyPublisher<Bool, Error>
    
    
    // Meal
    func getMeals(by category: String) -> AnyPublisher<[MealEntity], Error>
    func addMeals(by category: String, from meals: [MealEntity]) -> AnyPublisher<Bool, Error>
    func getMeal(by idMeal: String) -> AnyPublisher<MealEntity, Error>
    func updateMeal(by idMeal: String, meal: MealEntity) -> AnyPublisher<Bool, Error>
    
    // search
    func addMealsBy(_ title: String, from meals: [MealEntity]) -> AnyPublisher<Bool, Error>
    func getMealsBy(_ title: String) -> AnyPublisher<[MealEntity], Error>
    
    // Favorites
    func getFavoritesMeals() -> AnyPublisher<[MealEntity], Error>
    func updateFavoriteMeal(by idMeal: String) -> AnyPublisher<MealEntity, Error>
    
}

final class LocalDataSource: NSObject {
    private let realm: Realm?
    private init(realm: Realm?) {
        self.realm = realm
    }
    
    static let sharedInstance: (Realm?) -> LocalDataSource = { realmDb in
        return LocalDataSource(realm: realmDb)
    }
}

extension LocalDataSource: LocalDataSourceProtocol {
    
    // category
    func getCategories() -> AnyPublisher<[CategoryEntity], Error> {
        return Future<[CategoryEntity], Error> { completion in
            if let realm = self.realm {
                let categories: Results<CategoryEntity> = {
                    realm.objects(CategoryEntity.self)
                        .sorted(byKeyPath: "title", ascending: true)
                }()
                completion(.success(categories.toArray(ofType: CategoryEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func addCategories(from categories: [CategoryEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        for category in categories {
                            realm.add(category, update: .all)
                        }
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    
    // meals
    func getMeals(by category: String) -> AnyPublisher<[MealEntity], Error> {
        return Future<[MealEntity], Error> { completion in
            if let realm = self.realm {
                let meals: Results<MealEntity> = {
                    realm.objects(MealEntity.self)
                        .filter("category = '\(category)'")
                        .sorted(byKeyPath: "title", ascending: true)
                }()
                completion(.success(meals.toArray(ofType: MealEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func getMeal(by idMeal: String) -> AnyPublisher<MealEntity, Error> {
        Deferred {
            () -> AnyPublisher<MealEntity, Error> in
            guard let realm = self.realm else {
                return Fail(error: DatabaseError.invalidInstance).eraseToAnyPublisher()
            }
            if let meal = realm.objects(MealEntity.self).filter("id == %@", idMeal).first {
                return Just(meal).setFailureType(to: Error.self).eraseToAnyPublisher()
            } else {
                return Empty<MealEntity, Error>(completeImmediately: true).eraseToAnyPublisher()
            }
        }
        .eraseToAnyPublisher()
    }
    
    
    func updateMeal(
        by idMeal: String,
        meal: MealEntity
    ) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm, let mealEntity = {
                realm.objects(MealEntity.self).filter("id = '\(idMeal)'")
            }().first {
                do {
                    try realm.write {
                        mealEntity.setValue(meal.area, forKey: "area")
                        mealEntity.setValue(meal.instructions, forKey: "instructions")
                        mealEntity.setValue(meal.tag, forKey: "tag")
                        mealEntity.setValue(meal.youtube, forKey: "youtube")
                        mealEntity.setValue(meal.source, forKey: "source")
                        mealEntity.setValue(meal.favorite, forKey: "favorite")
                        mealEntity.setValue(meal.ingredients, forKey: "ingredients")
                    }
                    completion(.success(true))
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func addMeals(by category: String, from meals: [MealEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            
            if let realm = self.realm {
                do {
                    try realm.write {
                        for meal in meals {
                            realm.add(meal, update: .all)
                        }
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func getFavoritesMeals() -> AnyPublisher<[MealEntity], Error> {
        return Future<[MealEntity], Error> { completion in
            if let realm = self.realm {
                let mealEntities = {
                    realm.objects(MealEntity.self)
                        .filter("favorite = \(true)")
                        .sorted(byKeyPath: "title", ascending: true)
                }()
                completion(.success(mealEntities.toArray(ofType: MealEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func updateFavoriteMeal(by idMeal: String) -> AnyPublisher<MealEntity, Error> {
        return Future<MealEntity, Error> { completion in
            if let realm = self.realm, let mealEntity = {
                realm.objects(MealEntity.self).filter("id = '\(idMeal)'")
            }().first {
                do {
                    try realm.write {
                        mealEntity.setValue(!mealEntity.favorite, forKey: "favorite")
                    }
                    completion(.success(mealEntity))
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    // Search Meal
    func addMealsBy(_ title: String, from meals: [MealEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        for meal in meals {
                            if let mealEntity = realm.object(ofType: MealEntity.self, forPrimaryKey: meal.id) {
                                if mealEntity.title == meal.title {
                                    meal.favorite = mealEntity.favorite
                                    realm.add(meal, update: .all)
                                } else {
                                    realm.add(meal)
                                }
                            } else {
                                realm.add(meal)
                            }
                        }
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    
    func getMealsBy(
        _ title: String
    ) -> AnyPublisher<[MealEntity], Error> {
        return Future<[MealEntity], Error> { completion in
            if let realm = self.realm {
                let meals: Results<MealEntity> = {
                    realm.objects(MealEntity.self)
                        .filter("title contains[c] %@", title)
                        .sorted(byKeyPath: "title", ascending: true)
                }()
                completion(.success(meals.toArray(ofType: MealEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
}
