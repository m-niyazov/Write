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
    
    // MARK: - Selectors
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    // MARK: - Helpers
    
    
    func configureUI() {
        view.backgroundColor = .black
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = .white
    }
}
