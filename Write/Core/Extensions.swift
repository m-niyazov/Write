//
//  Extensions.swift
//  Write
//
//  Created by Muhamed Niyazov on 20.03.2021.
//

import Foundation
import UIKit

//MARK: - UIColor
extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1)
    }
    
    static let bgGray = UIColor.rgb(red: 20, green: 20, blue: 20)
    static let milk = UIColor.rgb(red: 244, green: 244, blue: 244)
}

//MARK: - UITextField
extension UITextField {
    func addBottomBorder(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = UIColor.white.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}

//MARK: - UIButton
extension UIButton {
    static func animateHandleButton(sender: UIButton, complition: @escaping () -> ()) {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                        complition()
                       }, completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            sender.transform = CGAffineTransform.identity
                        }
                       })
    }
    
}

//MARK: - UIEdgeInsets
extension UIEdgeInsets {
    static let mainInsets = UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15)
}

//MARK: - UISearchBar
extension UIImage {
    class func image(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            color.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}

extension UISearchBar {
    func customize() {
        setSearchFieldBackgroundImage(UIImage.image(color: .clear, size: CGSize(width: 1, height: 44)), for: .normal)
        
        // other settings
        placeholder = "Search"
        tintColor = .lightGray
        
        searchTextField.backgroundColor = UIColor.rgb(red: 38, green: 38, blue: 38)
        searchTextField.layer.cornerRadius = 10
        searchTextField.layer.masksToBounds = true
    }
}
