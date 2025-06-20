//
//  SceneDelegate.swift
//  Unsplash_test
//
//  Created by Алексей Колыченков on 20.06.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let winScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: winScene)
        let mainVC = ModelBuilder.createMainScreen()
        let navVC = UINavigationController(rootViewController: mainVC)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }

}

