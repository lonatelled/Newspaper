//
//  AppDelegate.swift
//  Newspaper
//
//  Created by Дарья Каркоцкая on 7.05.22.
//

import UIKit
import Firebase
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        Auth.auth().addStateDidChangeListener { auth, user in
            if user == nil {
                self.showModalAuth()
            }
        }
        return true
    }
    
    func showModalAuth() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newVC = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        newVC.modalPresentationStyle = .fullScreen
        self.window?.rootViewController?.present(newVC, animated: true, completion: nil)
    }
    

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }


}

