//
//  SettingsController.swift
//  Write_
//
//  Created by Muhamed Niyazov on 07.01.2021.
//  Copyright © 2021 Muhamed Niyazov. All rights reserved.
//

import Foundation
import UIKit

class SettingsController: UIViewController {
    // MARK: - Properties
    
    // MARK: - Selectors
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    // MARK: - Helpers
    
    
    func configureUI() {
        title = "Settings"
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        let navigationBar = navigationController!.navigationBar
        navigationBar.barTintColor = .grayDark
        navigationBar.isTranslucent = false
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
}
