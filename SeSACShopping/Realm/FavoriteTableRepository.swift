//
//  FavoriteTableRepository.swift
//  SeSACShopping
//
//  Created by 차소민 on 2/18/24.
//

import Foundation
import RealmSwift

final class FavoriteTableRepository {
    
    private let realm = try! Realm()
    
    // MARK: Create
    func createItem(_ item: FavoriteTable) {
        print(realm.configuration.fileURL)

        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print(error)
        }
    }
    
    // MARK: Read
    func read() -> Results<FavoriteTable> {
        realm.objects(FavoriteTable.self)
    }
    
    // MARK: Delete
    func deleteItem(_ item: FavoriteTable) {
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            
        }
    }
}
