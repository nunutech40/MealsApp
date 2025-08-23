//
//  LocalDataSource.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 16/08/25.
//

import Foundation
import RealmSwift
import RxSwift

protocol LocalDataSourceProtocol: AnyObject {
    
    func getCategories() -> Observable<[CategoryEntity]>
    func addCategories(from categories: [CategoryEntity]) -> Observable<Bool>
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
    func getCategories() -> Observable<[CategoryEntity]> {
        return Observable.create { observer in
            if let realm = self.realm {
                let categories: Results<CategoryEntity> = {
                    realm.objects(CategoryEntity.self)
                        .sorted(byKeyPath: "title", ascending: true)
                }()
                observer.onNext(categories.toArray(ofType: CategoryEntity.self))
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func addCategories(from categories: [CategoryEntity]) -> Observable<Bool> {
        return Observable.create { observer in
            if let realm = self.realm {
                do {
                    try realm.write {
                        for category in categories {
                            realm.add(category, update: .all)
                        }
                        observer.onNext(true)
                    }
                } catch {
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
}
