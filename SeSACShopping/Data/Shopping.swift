//
//  Shopping.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/18/24.
//

import Foundation

struct Shopping: Codable {
    let total: Int
    let start: Int
    let display: Int
    let items: [Item]
}

struct Item: Codable {
    let title: String
    let link: String
    let image: String
    let lprice: String
    let hprice: String
    let mallName: String
    let productId: String
    let productType: String
    let brand: String
    let maker: String
    let category1: String
    let category2: String
    let category3: String
    let category4: String
}
