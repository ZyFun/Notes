//
//  AppDelegate.swift
//  Notes
//
//  Created by Дмитрий Данилин on 21.12.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        createAndShowStartVC()
        
        return true
    }
}

// MARK: - Initial application settings

private extension AppDelegate {
    /// Создание и отображение стартового ViewController
    func createAndShowStartVC() {
        let mainVC = NoteListViewController(
            nibName: String(describing: NoteListViewController.self),
            bundle: nil
        )
        
        let navigationController = UINavigationController(
            rootViewController: mainVC
        )
        
        PresentationAssembly().noteList.config(
            view: mainVC,
            navigationController: navigationController
        )
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
