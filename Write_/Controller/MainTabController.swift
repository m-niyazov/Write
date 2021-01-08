//
//  MainTabController.swift
//  Write_
//
//  Created by Muhamed Niyazov on 07.01.2021.
//  Copyright © 2021 Muhamed Niyazov. All rights reserved.
//

import Foundation
import UIKit
import SnapKit


class MainTabController: UITabBarController  {
    // MARK: - Properties
    
    // MARK: - Selectors
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTabControllers()
    }
    // MARK: - Helpers
    
    func configureTabControllers() {
        let documentsController = DocumentsController()
        let navDocuments = templateNavigatinController(navTitle: "Documents", iconName: "documents-icon", rootController: documentsController)
        
        let readerModeController = ReaderModeController()
        let navReaderMode = templateNavigatinController(navTitle: "Reader Mode", iconName: "bookmark-icon", rootController: readerModeController)
        
        let settingsController = SettingsController()
        let navSettings = templateNavigatinController(navTitle: "Settings", iconName: "settings-icon", rootController: settingsController)
              
        
        viewControllers = [navDocuments, navReaderMode, navSettings]
    }
    
    func templateNavigatinController(navTitle: String, iconName: String, rootController: UIViewController) -> UINavigationController {
        let viewController = UINavigationController(rootViewController: rootController)
        viewController.tabBarItem.image = UIImage(named: iconName)
        viewController.tabBarItem.selectedImage = UIImage(named: "\(iconName)-selected")
        viewController.title = navTitle
        return viewController
    }
    
    func configureUI() {
        view.backgroundColor = .yellow
        //tabBar
        tabBar.barTintColor = UIColor.rgb(red: 20, green: 20, blue: 20)
        tabBar.unselectedItemTintColor = UIColor.rgb(red: 90, green: 90, blue: 90)
        tabBar.tintColor = .white
        
        
    }
}
