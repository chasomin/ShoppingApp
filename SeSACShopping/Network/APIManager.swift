//
//  APIManager.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/18/24.
//

import Foundation
import Alamofire

enum RequestError: String, Error {
    case failedRequest = "데이터 요청에 실패했습니다"
    case noData = "알맞는 데이터가 존재하지 않습니다"
    case invaildData = "유효하지 않은 데이터입니다"
    case invaildResponse = "유효하지 않은 응답값입니다"
}

struct APIManager {
    
    static let shard = APIManager()
    
    private init() { }
    
//    func callRequest(text: String, start: Int, sort: String, completionHandler: @escaping (Shopping) -> ()) {
//        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(query)&display=30&start=\(start)&sort=\(sort)"
//        let headers: HTTPHeaders = ["X-Naver-Client-Id":APIKey.clientID,
//                                    "X-Naver-Client-Secret":APIKey.clientSecret]
//        
//        AF.request(url,
//                   method: .get,
//                   headers: headers)
//        .responseDecodable(of: Shopping.self) { response in
//            switch response.result {
//            case .success(let success):
//                dump(success.total)
//                
//                completionHandler(success)
//                
//            case .failure(let failure):
//                print(failure)
//            }
//        }
//    }
    

    func request(text: String, start: Int, sort: String) async throws -> Shopping {
        guard let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return Shopping.init(total: 0, start: 0, display: 0, items: [])
        }

        var components = URLComponents()
        components.scheme = "https"
        components.host = "openapi.naver.com"
        components.path = "/v1/search/shop.json"
        components.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "display", value: "30"),
            URLQueryItem(name: "start", value: "\(start)"),
            URLQueryItem(name: "sort", value: sort)
        ]
        
        guard let url = components.url else {
            print("!@!@에러11")
            throw RequestError.failedRequest
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.headers = [
            HTTPHeader(name: "X-Naver-Client-Id", value: APIKey.clientID),
            HTTPHeader(name: "X-Naver-Client-Secret", value: APIKey.clientSecret)
        ]
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
            print("!@!@에러22")
            throw RequestError.failedRequest
        }
        
        do {
            let result = try JSONDecoder().decode(Shopping.self, from: data)
            dump(result)
            return result
        } catch {
            throw RequestError.invaildData
        }
    }
    
}
