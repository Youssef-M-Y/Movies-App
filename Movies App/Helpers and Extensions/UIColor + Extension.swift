//
//  UIColor + Extension.swift
//  Movies App
//
//  Created by OmarMansour on 2/22/21.
//  Copyright © 2021 Youssef. All rights reserved.
//

import UIKit

extension UIColor
{
    var isDarkColor: Bool {
        var r, g, b, a: CGFloat
        (r, g, b, a) = (0, 0, 0, 0)
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        let lum = 0.2126 * r + 0.7152 * g + 0.0722 * b
        return  lum < 0.50
    }
}
