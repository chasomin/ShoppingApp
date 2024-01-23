//
//  APIManager.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/18/24.
//

import Foundation
import Alamofire

enum Sort: String{
    case accuracy = "sim"
    case date = "date"
    case highPrice = "dsc" // 가격 높은 순
    case lowPrice = "asc" // 저렴한 순
}

struct APIManager {
    
    static let shard = APIManager()
    
    func callRequest(text: String, start: Int, sort: String, completionHandler: @escaping (Shopping) -> ()) {
        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(query)&display=30&start=\(start)&sort=\(sort)"
        let headers: HTTPHeaders = ["X-Naver-Client-Id":APIKey.clientID,
                                    "X-Naver-Client-Secret":APIKey.clientSecret]
        
        AF.request(url,
                   method: .get,
                   headers: headers)
        .responseDecodable(of: Shopping.self) { response in
            switch response.result {
            case .success(let success):
                dump(success.total)
                
                completionHandler(success)
                
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
