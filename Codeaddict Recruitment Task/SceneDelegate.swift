//
//  SceneDelegate.swift
//  Codeaddict Recruitment Task
//
//  Created by Tomasz Paluch on 19/05/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UINavigationController(
            rootViewController: SearchViewController(
                viewModel: .init(
                    navigationItemTitle: "Search",
                    headerViewLabelText: "Repositories"
                )
            )
        )
        self.window = window
        window.makeKeyAndVisible()
    }
}

