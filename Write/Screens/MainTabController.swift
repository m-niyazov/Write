//
//  MainTabController.swift
//  Write
//
//  Created by Muhamed Niyazov on 20.03.2021.

import UIKit
import Firebase

class MainTabController: UITabBarController {
    
    //MARK: - Lifecylce
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        authenticateUserAndConfigureUI()
        
    }
    
    //MARK: - Helpers
    func  authenticateUserAndConfigureUI() {
        // User is not logged in
        guard Auth.auth().currentUser != nil  else {
            tabBar.isHidden = true
            DispatchQueue.main.async {
                let loginScreen = LoginBuilder().makeScene()
                let navLoginScreen = UINavigationController(rootViewController: loginScreen)
                navLoginScreen.modalPresentationStyle = .fullScreen
                self.present(navLoginScreen, animated: true, completion: nil)
            }
            return
        }
        // User is authorized
        tabBar.isHidden = false
        configureTabBar()
        configureViewControllers()
    }
    
    func configureViewControllers(){
        let documentsScreen =  DocumentsBuilder().makeScene()
        let navDocumentsScreen = addNavigationController(documentsScreen, icon: "documents-icon", title: "Documents")
        
        let settingsScreen =  SettingsBuilder().makeScene()
        let navSettingsController =  addNavigationController(settingsScreen, icon: "settings-icon", title: "Settings")
        
        viewControllers = [navDocumentsScreen, navSettingsController]
    }
    
    func configureTabBar() {
        tabBar.barTintColor = UIColor.bgGray
        tabBar.isTranslucent = false
        tabBar.unselectedItemTintColor = .rgb(red: 192, green: 192, blue: 192)
        tabBar.tintColor = .white
    }
    
    func addNavigationController(_ controller: UIViewController, icon: String, title: String) -> UIViewController {
        let controller = UINavigationController(rootViewController: controller)
        controller.tabBarItem.image = UIImage(named: icon)
        controller.tabBarItem.selectedImage = UIImage(named: "\(icon)-selected")
        controller.title = title
        return controller
    }
}
