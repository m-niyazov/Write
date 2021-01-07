//
//  DocumentsController.swift
//  Write_
//
//  Created by Muhamed Niyazov on 07.01.2021.
//  Copyright © 2021 Muhamed Niyazov. All rights reserved.
//

import Foundation
import UIKit

class DocumentsController: UIViewController {
    // MARK: - Properties
    
    // MARK: - Selectors
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    // MARK: - Helpers
    
    
    func configureUI(){
        view.backgroundColor = .black
        //navigationBar
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = .white
     
        let logo = UIImage(named: "main-logo")
        let imageView = UIImageView(image: logo)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 75).isActive = true
        navigationItem.titleView = imageView
        
    
    }
}
