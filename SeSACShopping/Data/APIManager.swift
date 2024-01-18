//
//  APIManager.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/18/24.
//

import Foundation
import Alamofire

struct APIManager {
    
    func callRequest(text: String, start: Int, completionHandler: @escaping (Shopping) -> ()) {
        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(query)&display=30&start=\(start)"
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
