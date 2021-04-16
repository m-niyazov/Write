//
//  MainTabController.swift
//  Write
//
//  Created by Muhamed Niyazov on 20.03.2021.

import UIKit
import Firebase

class MainTabController: UITabBarController {
    // MARK: - Properties

    
    //MARK: - Lifecylce
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        authenticateUserAndConfigureUI()
    }
    
    //API
    func  authenticateUserAndConfigureUI() {
        // User is NOT logged in
        guard Auth.auth().currentUser != nil  else {
            DispatchQueue.main.async {
                let loginController = UINavigationController(rootViewController: LoginController())
                loginController.modalPresentationStyle = .fullScreen
                self.present(loginController, animated: true, completion: nil)
            }
            return
        }
        // User is logged in
        configureViewControllers()
        configureTabBar()
    }
    

    //MARK: - Helpers
    func configureViewControllers(){
        let documentsController = addNavigationController(controller: DocumentsController(),
                                                          icon: "documents-icon",
                                                          title: "Documents")
        
 
        
        let settingController =  addNavigationController(controller: SettingsController(),
                                                         icon: "settings-icon",
                                                         title: "Settings")
        
        
        viewControllers = [documentsController, settingController]
    }
    
    func configureTabBar() {
        tabBar.barTintColor = UIColor.tabBar
        tabBar.isTranslucent = false
        tabBar.unselectedItemTintColor = UIColor.gray
        tabBar.tintColor = .white
        print("DEBUG: \(tabBar.frame.height)")
    }
    
    func addNavigationController(controller: UIViewController, icon: String, title: String) -> UIViewController {
        let controller = UINavigationController(rootViewController: controller)
        controller.tabBarItem.image = UIImage(named: icon)
        controller.tabBarItem.selectedImage = UIImage(named: "\(icon)-selected")
        controller.title = title
        return controller
    }
    
}
