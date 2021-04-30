//
//  UtilitiesUI.swift
//  Write
//
//  Created by Muhamed Niyazov on 20.03.2021.
//

import Foundation
import UIKit
import SnapKit

final class UtilitiesUI {
    enum NavStyle {
        case light
        case dark
    }
    
    static let instance = UtilitiesUI()
    private init() {}
    
    //MARK: - Main
    func  basicNavBarSettings(_ style: NavStyle, _ navigationBar: UINavigationBar, _ navigationItem: UINavigationItem) {
        let logo = UIImage(named: "\(style == NavStyle.light ? "main-logo-gray" : "main-logo")")
        
        let imageView = UIImageView(image: logo)
        imageView.snp.makeConstraints { (make) in
            make.width.equalTo(75)
            make.height.equalTo(20)
        }
        navigationItem.titleView = imageView
        navigationBar.barStyle = style == NavStyle.light ? .default : .black
        navigationBar.barTintColor = style == NavStyle.light ? .milk : .black
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = false
    }
    
    
    //MARK: - Document Read/Edit/Create
    func barButtonItem(title: String, iconName: String? ) -> UIBarButtonItem {
        let button = UIBarButtonItem()
        button.style = .done
        button.title = title
        button.tintColor = UIColor.rgb(red: 121, green: 121, blue: 121)
        guard iconName != nil else { return button }
        let buttonIcon = UIImage(systemName: "trash")
        button.image = buttonIcon
        return button
    }
}
