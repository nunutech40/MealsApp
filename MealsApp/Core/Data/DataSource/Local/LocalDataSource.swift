//
//  LocalDataSource.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 16/08/25.
//

import Foundation
import RealmSwift

protocol LocalDataSourceProtocol: AnyObject {
    
    func getCategories(result: @escaping (Result<[CategoryEntity], DatabaseError>) -> Void)
    func addCategories(from categories: [CategoryEntity], result: @escaping (Result<Bool, DatabaseError>) -> Void)
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
    
    // get categories dari db realm dan kirim ke success dalam bentuk array
    func getCategories(result: @escaping (Result<[CategoryEntity], DatabaseError>) -> Void) {
        if let realm = realm {
            let categories: Results<CategoryEntity> = {
                realm.objects(CategoryEntity.self)
                    .sorted(byKeyPath: "title", ascending: true)
            }()
            result(.success(categories.toArray(ofType: CategoryEntity.self)))
        } else {
            result(.failure(.invalidInstance))
        }
    }
    
    func addCategories(from categories: [CategoryEntity], result: @escaping (Result<Bool, DatabaseError>) -> Void) {
        if let realm = realm {
            do {
                try realm.write {
                    for category in categories {
                        realm.add(category, update: .all)
                    }
                    result(.success(true))
                }
            } catch {
                result(.failure(.requestFailed))
            }
        }
    }
    
}
