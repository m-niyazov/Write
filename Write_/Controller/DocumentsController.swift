//
//  DocumentsController.swift
//  Write_
//
//  Created by Muhamed Niyazov on 07.01.2021.
//  Copyright © 2021 Muhamed Niyazov. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

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
        
        imageView.snp.makeConstraints { (make) in
            make.width.equalTo(75)
            make.height.equalTo(20)
        }
    
        navigationItem.titleView = imageView
        
    
    }
}
