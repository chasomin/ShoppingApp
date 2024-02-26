//
//  FavoriteRealmModel.swift
//  SeSACShopping
//
//  Created by 차소민 on 2/18/24.
//

import Foundation
import RealmSwift

final class FavoriteTable: Object {
//    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted(primaryKey: true) var product: String
    @Persisted var title: String
    @Persisted var link: String
    @Persisted var image: String
    @Persisted var lprice: String
    @Persisted var mallName: String

    
    var titleFilter: String {
        let filterTitle = title.replacingOccurrences(of: "<b>", with: "")
        let resultTitle = filterTitle.replacingOccurrences(of: "</b>", with: "")
        return resultTitle
    }
    
   convenience init(product: String, title: String, link: String, image: String, lprice: String, mallName: String) {
        self.init()
        self.product = product
        self.title = title
        self.link = link
        self.image = image
        self.lprice = lprice
        self.mallName = mallName
    }
}
