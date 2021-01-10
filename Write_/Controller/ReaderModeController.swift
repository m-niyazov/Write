//
//  ReaderModeController.swift
//  Write_
//
//  Created by Muhamed Niyazov on 07.01.2021.
//  Copyright © 2021 Muhamed Niyazov. All rights reserved.
//

import Foundation
import UIKit

class ReaderModeController: UIViewController {
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    // MARK: - Helpers
    
    
    func configureUI() {
        configureNavigationBar()
        addCollectionController()
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = .white
        let logo = UIImage(named: "main-logo")
        let imageView = UIImageView(image: logo)
        imageView.snp.makeConstraints { (make) in
            make.width.equalTo(75)
            make.height.equalTo(20)
        }
        navigationItem.titleView = imageView
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func addCollectionController() {
        let noteColletionController = NoteColletionViewController(viewModel: ReaderModeControllerVM())
        addChild(noteColletionController)
        view.addSubview(noteColletionController.view)
    }
}

