//
//  HelperFunctions.swift
//  Movies App
//
//  Created by OmarMansour on 2/20/21.
//  Copyright © 2021 Youssef. All rights reserved.
//

import Foundation

class HelperFunctions{

    class func convertDateFormater(_ date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: date){
            dateFormatter.dateFormat = "dd MMM yyyy"
            return  dateFormatter.string(from: date)
        }
        else {
            return ""
        }
    }

}
