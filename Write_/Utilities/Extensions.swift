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
    
    static let textGreen = UIColor.rgb(red: 0, green: 221, blue: 82)
    
    static let textGray = UIColor.rgb(red: 90, green: 90, blue: 90)
}


//MARK: NavigationController
extension UINavigationController {

    func pushViewControllerWithFlipAnimation(viewController:UIViewController){
        self.pushViewController(viewController
        , animated: false)
        if let transitionView = self.view{
            UIView.transition(with:transitionView, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        }
    }

    func popViewControllerWithFlipAnimation(){
        self.popViewController(animated: false)
        if let transitionView = self.view{
            UIView.transition(with:transitionView, duration: 0.5, options: .transitionFlipFromRight, animations: nil, completion: nil)
        }
    }
}


//MARK: - UIEdgeInsets

extension UIEdgeInsets {
    static let mainInsets = UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15)
}


