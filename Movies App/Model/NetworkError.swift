//
//  NetworkError.swift
//  Movies App
//
//  Created by OmarMansour on 1/25/21.
//  Copyright © 2021 Youssef. All rights reserved.
//

import Foundation

struct NetworkError: Codable , Error{
    let message: String?
    
    enum CodingKeys: String, CodingKey{
        case message = "status_message"
    }
}
