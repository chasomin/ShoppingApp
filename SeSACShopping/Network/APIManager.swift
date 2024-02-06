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
    

    func request(text: String, start: Int, sort: String, completionHandler:  @escaping (Shopping?, RequestError?) -> ()) {
        guard let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }

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
            print("url nil")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.headers = [
            HTTPHeader(name: "X-Naver-Client-Id", value: APIKey.clientID),
            HTTPHeader(name: "X-Naver-Client-Secret", value: APIKey.clientSecret)
        ]
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            DispatchQueue.main.async {
                
                guard error == nil else {
                    print("error!!")
                    completionHandler(nil, .failedRequest)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    print("상태코드 오류")
                    completionHandler(nil, .invaildResponse)
                    return
                }
                
                guard let data else {
                    print("데이터 오류")
                    completionHandler(nil, .noData)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(Shopping.self, from: data)
                    dump(result)
                    completionHandler(result, nil)
                } catch {
                    print(error)
                    completionHandler(nil, .invaildData)
                }
            }
        }.resume()
    }
    
}
