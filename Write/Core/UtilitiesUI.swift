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
    func basicNavBarSettings(_ style: NavStyle, _ navigationController: UINavigationController, _ navigationItem: UINavigationItem) {
        let navigationBar = navigationController.navigationBar
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
    
    //MARK: - Authentication
    func textFieldWithPlaceholder(withPlaceholder placeholder : String) -> UITextField {
        let textField = UITextField()
        textField.textColor = .white
        textField.backgroundColor = .none
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.4470588235, green: 0.4470588235, blue: 0.4470588235, alpha: 1)])
        textField.borderStyle = .none
        
        return textField
    }
    
    func textFieldContainer(_ textField: UITextField) -> UIView {
        let view = UIView()
        view.snp.makeConstraints { (make) in
            make.height.equalTo(50)
        }
        
        view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.left.equalTo(view)
            make.centerY.equalTo(view)
            make.right.equalTo(view)
        }
        
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        view.addSubview(dividerView)
        dividerView.snp.makeConstraints { make in
            make.height.equalTo(0.8)
            make.width.equalTo(view)
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.bottom.equalTo(view)
        }
        
        return view
    }
    
    func attributedButton(_ firstPart: String, _ secondPart: String) -> UIButton {
        let button = UIButton(type: .system)
        let attributedText = NSMutableAttributedString(string: firstPart,
                                                       attributes: [.font : UIFont.systemFont(ofSize: 16),
                                                                    .foregroundColor: UIColor.white])
        let secondPartText = NSAttributedString(string: secondPart,
                                                attributes: [.font : UIFont.boldSystemFont(ofSize: 16),
                                                             .foregroundColor: UIColor.white])
        attributedText.append(secondPartText)
        button.setAttributedTitle(attributedText, for: .normal)
        return button
    }
    
    //MARK: - Documents
    func  createDocumentButton() -> UIButton {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = UIColor.rgb(red: 38, green: 38, blue: 38)
        button.setImage(UIImage(named: "add-icon"), for: .normal)
        button.layer.cornerRadius = 66 / 2
        
        return button
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
