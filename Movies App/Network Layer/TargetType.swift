//
//  TargetType.swift
//  Movies App
//
//  Created by OmarMansour on 1/21/21.
//  Copyright © 2021 Youssef. All rights reserved.
//

import Foundation
import Alamofire

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

//Rapper for Our Requests Type

protocol TargetType {
    var baseURL: String { get }
    
    var path: String { get }
    
    var method: HTTPMethods { get }
    
    var headers: [String: String]? { get }
}
