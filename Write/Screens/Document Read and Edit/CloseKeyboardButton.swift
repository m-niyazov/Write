//
//  CloseKeyboardButton.swift
//  Write
//
//  Created by Muhamed Niyazov on 07.04.2021.

import  Foundation
import UIKit



class CloseKeyboardButton: UIView {
    var textLabel: UIImageView = {
        let configuration = UIImage.SymbolConfiguration( scale: .large)
        var icon = UIImage(systemName: "keyboard.chevron.compact.down", withConfiguration: configuration)
        let grayColor =  UIColor.rgb(red: 121, green: 121, blue: 121)
        let grayIcon = icon?.withTintColor(grayColor, renderingMode: .alwaysOriginal)
        let imageView = UIImageView(image: grayIcon)
        imageView.isUserInteractionEnabled = true
        
        let overlay = UIButton(frame: imageView.bounds)
        overlay.addTarget(self, action: #selector(imageViewTapped), for: .touchUpInside)
        imageView.addSubview(overlay)
        overlay.backgroundColor = .none
        return imageView
    }()
    
    @objc func imageViewTapped() {
        let notifiCenter = NotificationCenter.default
        notifiCenter.post(name: NSNotification.Name(rawValue: "closeKeyboard"), object: nil, userInfo: nil)
    }
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 1, height: 42))
        addSubview(textLabel)
        backgroundColor = .none
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            textLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
