//
//  File.swift
//  Movies App
//
//  Created by OmarMansour on 1/21/21.
//  Copyright © 2021 Youssef. All rights reserved.
//

import Foundation
import Alamofire

class AlamoFireNetworking<T: Codable> :NetworkingProtocol {
    
    func makeRequest(baseUrl: String, uri: String, method: String, body: [String : Any]?, headers: [String : String]?, queryParams: [String : String]?, completion: @escaping (Result<HttpResponse?, HttpResponse>) -> Void) {
        let method = Alamofire.HTTPMethod(rawValue: method)
        let headers = Alamofire.HTTPHeaders(headers ?? [:])
        
        DispatchQueue.global().async {
            AF.request(baseUrl + uri, method: method, parameters: body, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
                guard let statusCode = response.response?.statusCode else {
                    completion(.failure(.init(code: 0, body: nil, headers: nil)))
                    return
                }
                                
                if statusCode/100 == 2 {
                    print(statusCode)
                    
                    guard let headerResponse = response.response?.allHeaderFields as? [String: String] else {
                        return
                    }
                    
                    guard let jsonResponse = try? response.result.get() else {
                        let httpResponse = HttpResponse(code: statusCode, body: nil, headers: headerResponse)
                        completion(.success(httpResponse))
                        return
                    }
                    
                    self.configureResponse(jsonResponse: jsonResponse, statusCode: statusCode, headers: headerResponse, completion: completion)
                    
                } else if statusCode/100 == 4 {
                    print(statusCode)
                    guard let headerResponse = response.response?.allHeaderFields as? [String: String] else {
                        return
                    }
                    
                    guard let jsonResponse = try? response.result.get() else {
                        let httpResponse = HttpResponse(code: statusCode, body: nil, headers: headerResponse)
                        completion(.failure(httpResponse))
                        return
                    }
                    
                    self.configureResponse(jsonResponse: jsonResponse, statusCode: statusCode, headers: headerResponse, completion: completion)
                } else {
                    completion(.failure(HttpResponse(code: statusCode, body: NetworkError(message: "Something went wrong, Please try again later"), headers: nil)))
                    print(statusCode)
                    print(Error.self)
                }
            }
        }
    }
    
    private func configureResponse(jsonResponse: Any, statusCode: Int, headers: [String: String]?, completion: @escaping (Result<HttpResponse?, HttpResponse>) -> Void) {
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonResponse, options: []) else {
            return
        }
        
        guard let responseObj = try? JSONDecoder().decode(T.self, from: jsonData) else {
            return
        }
        
        let httpResponse = HttpResponse(code: statusCode, body: responseObj, headers: headers)
        
        if (statusCode/100 == 2){
            completion(.success(httpResponse))
        }
        else{
            completion(.failure(httpResponse))
        }
    }
}
