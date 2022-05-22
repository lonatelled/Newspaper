//
//  ForgotPasswordViewController.swift
//  Newspaper
//
//  Created by Дарья Каркоцкая on 19.05.22.
//

import UIKit
import Firebase
import FirebaseAuth

final class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func forgotPasswordAction(_ sender: UIButton) {
        let email = emailTF.text!
        if (!email.isEmpty) {
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if error == nil {
                    self.navigationController?.popToRootViewController(animated: false)
                }
            }

        }
    }
}
