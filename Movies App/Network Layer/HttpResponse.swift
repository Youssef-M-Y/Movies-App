//
//  HttpResponse.swift
//  Movies App
//
//  Created by OmarMansour on 1/21/21.
//  Copyright © 2021 Youssef. All rights reserved.
//

import Foundation

struct HttpResponse: Error {
    public let code: Int
    public let body: Codable?
    public let headers: [String:String]?
    
    init(code: Int, body: Codable?, headers: [String: String]?) {
        self.code = code
        self.body = body
        self.headers = headers
    }
}
