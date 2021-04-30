//
//  AuthUtilitiesUI.swift
//  Write
//
//  Created by Muhamed Niyazov on 18.04.2021.
//

import Foundation
import UIKit
import SnapKit


class AuthUtilitiesUI  {
    
    //MARK: - Returnable views
    func logoImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "main-logo")
        return imageView
    }
    
    func mainActionButtonContainer(_ subviews: [UIView]) -> UIStackView {
        let subviews = subviews
        let view = UIStackView(arrangedSubviews: subviews)
        view.axis = .vertical
        view.spacing = 15
        return view
    }
    
    func stackViewForTextFields(_ subviews: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: subviews)
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20
        return stackView
    }
    
    func errorLabel() ->  UILabel  {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .lightGray
        label.isHidden = true
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }
    
    func mainActionButton(withTitle title: String) -> UIButton  {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setAttributedTitle(NSAttributedString(string: title, attributes:  [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)]), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        isEnabledButton(button, isEnabled: false)
        return button
    }
    
    func textFieldWithPlaceholder(withPlaceholder placeholder : String) -> UITextField {
        let textField = UITextField()
        textField.textColor = .white
        textField.backgroundColor = .none
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.4470588235, green: 0.4470588235, blue: 0.4470588235, alpha: 1)])
        textField.borderStyle = .none
        return textField
    }
    
    func generateTextFieldContainer(_ textField: UITextField) -> UIView {
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
    
    func buttonWithTextAttributed(_ firstPart: String, _ secondPart: String) -> UIButton {
        let button = UIButton(type: .system)
        let attributedText = NSMutableAttributedString(string: firstPart, attributes: [.font : UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.white])
        let secondPartText = NSAttributedString(string: secondPart, attributes: [.font : UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.white])
        attributedText.append(secondPartText)
        button.setAttributedTitle(attributedText, for: .normal)
        return button
    }
    
    
    //MARK: - Same Helpers for Auth Screens
    func isErrorLabelHidden(_ label: UILabel, isHidden: Bool) {
        guard isHidden else {
            label.isHidden = false
            label.text = ""
            return
        }
        
        label.isHidden = true
    }
    
    func isEnabledButton(_ button: UIButton, isEnabled: Bool) {
        guard isEnabled else {
            button.isEnabled = false
            button.backgroundColor = .lightGray
            return
        }
        button.isEnabled = true
        button.backgroundColor = .white
    }
    
}
