//
//  APIManager.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/18/24.
//

import Foundation
import Alamofire

struct APIManager {
    
    func callRequest() {
        let url = "https://openapi.naver.com/v1/search/shop.json"
        let headers: HTTPHeaders = ["X-Naver-Client-Id":APIKey.clientID,
                                   "X-Naver-Client-Secret":APIKey.clientSecret]
        
        AF.request(url, method: .get, headers: headers)
            .responseDecodable(of: Shopping.self) { response in
                switch response.result {
                case .success(let success):
                    dump(success.items)
                case .failure(let failure):
                    print(failure)
                }
            }
    }
}
