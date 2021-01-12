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
        UtilitiesUI.instance.basicNavigationBarSettings(navigationController!, navigationItem)
    }
    
    func addCollectionController() {
        let noteColletionController = NoteColletionViewController(viewModel: ReaderModeControllerVM())
        addChild(noteColletionController)
        view.addSubview(noteColletionController.view)
    }
}

