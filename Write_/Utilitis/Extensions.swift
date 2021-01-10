//
//  Extensions.swift
//  Write_
//
//  Created by Muhamed Niyazov on 07.01.2021.
//  Copyright © 2021 Muhamed Niyazov. All rights reserved.
//

import Foundation
import UIKit


// MARK: - UIColor
extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1)
    }
    static let grayDark = UIColor.rgb(red: 20, green: 20, blue: 20)
    
    static let grayLight = UIColor.rgb(red: 38, green: 38, blue: 38)
    
    static let lightBlue = UIColor.rgb(red: 217, green: 245, blue: 245)
}



