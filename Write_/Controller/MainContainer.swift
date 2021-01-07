//
//  MainContainer.swift
//  Write_
//
//  Created by Muhamed Niyazov on 07.01.2021.
//  Copyright © 2021 Muhamed Niyazov. All rights reserved.
//

import Foundation
import UIKit

class MainContainer: UIViewController {
    // MARK: - Lifecyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHomeController()
    }
    
    // MARK: - Helpers
    func  configureHomeController() {
        view.backgroundColor = .blue
    }
    
}
