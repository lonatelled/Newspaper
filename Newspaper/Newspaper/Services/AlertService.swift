//
//  Allr.swift
//  Newspaper
//
//  Created by Дарья Каркоцкая on 24.05.22.
//

import Foundation
import UIKit

class AlertService {
    
    static let shared = AlertService()
    
    init() {}
    
    func alertAction(_ header: String?, _ message: String?) -> UIAlertController {
        let alert = UIAlertController(title: header, message: message, preferredStyle: .alert)
        return alert
    }
}

//class GoSignIn() {
//    static let shared = GoSignIn()
//    
//    init() {}
//    
//    func 
//}
//
