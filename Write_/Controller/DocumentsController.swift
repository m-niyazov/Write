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
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addCollectionController()
    }
    // MARK: - Helpers
    
    func configureUI() {
        configureNavigationBar()
    }
    
     func configureNavigationBar() {
        UtilitiesUI.instance.basicNavigationBarSettings(navigationController!, navigationItem)
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        backItem.tintColor = UIColor.white
        navigationItem.backBarButtonItem = backItem
    }
    
    func addCollectionController(){
        let noteColletionController = NoteColletionViewController(viewModel: DocumentsControllerVM())
        addChild(noteColletionController)
        view.addSubview(noteColletionController.view)
    }
}
