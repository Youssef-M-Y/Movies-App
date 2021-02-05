//
//  NetwrokProtocol.swift
//  Movies App
//
//  Created by OmarMansour on 1/21/21.
//  Copyright © 2021 Youssef. All rights reserved.
//

import Foundation


protocol NetworkingProtocol {
    
    func makeRequest(baseUrl: String, uri: String, method: String, body: [String:Any]?,headers: [String:String]?, queryParams: [String: String]?, completion:@escaping (Result<HttpResponse?, HttpResponse>) -> Void)
}
