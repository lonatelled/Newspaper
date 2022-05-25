//
//  TabbarController.swift
//  Newspaper
//
//  Created by Дарья Каркоцкая on 7.05.22.
//

import UIKit
import Firebase

final class TabbarController: UITabBarController {
    
    var user: User?
    var email: String?
    var pass: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
    }
}
