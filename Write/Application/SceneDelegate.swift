//
//  SceneDelegate.swift
//  Write
//
//  Created by Muhamed Niyazov on 20.03.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene =  windowScene
//        window?.rootViewController = UINavigationController(rootViewController: LoginController())
        window?.rootViewController = MainTabController()
        window?.makeKeyAndVisible()
    }


    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

