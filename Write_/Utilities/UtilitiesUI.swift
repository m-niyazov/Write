//
//  UtilitiesUI.swift
//  Write_
//
//  Created by Muhamed Niyazov on 11.01.2021.
//  Copyright © 2021 Muhamed Niyazov. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

final class UtilitiesUI {
    static let instance = UtilitiesUI()
    private init() {}
    
    //MARK: - MainUiSettings
    func basicNavigationBarSettings(_ navigationController: UINavigationController, _ navigationItem : UINavigationItem) {
        let navigationBar = navigationController.navigationBar
        navigationBar.barTintColor = .black
        navigationBar.tintColor = .white
        let logo = UIImage(named: "main-logo")
        let imageView = UIImageView(image: logo)
        imageView.snp.makeConstraints { (make) in
            make.width.equalTo(75)
            make.height.equalTo(20)
        }
        navigationItem.titleView = imageView
        navigationBar.barStyle = .black
        navigationBar.barTintColor = .black
        navigationBar.isTranslucent = false
        navigationBar.shadowImage = UIImage()
    }
    
    //MARK: - NewNoteController
    func readyTextView() -> UITextView {
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.textColor = .black
        textView.keyboardDismissMode = .interactive
        textView.isScrollEnabled = true
        textView.showsVerticalScrollIndicator = true
        textView.indicatorStyle = .black
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.contentInset = UIEdgeInsets.mainInsets
        textView.keyboardAppearance = .dark
        return textView
    }
    
    func readyContainerView() -> UIScrollView {
        let containerView = UIScrollView()
        containerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        containerView.keyboardDismissMode = .interactive
        containerView.showsVerticalScrollIndicator = false
        containerView.layer.cornerRadius = 10
        return containerView
    }
}
