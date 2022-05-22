//
//  SignInViewController.swift
//  Newspaper
//
//  Created by Дарья Каркоцкая on 19.05.22.
//

import UIKit
import Firebase
import FirebaseAuth

final class SignInViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var errorEmailLbl: UILabel!
    @IBOutlet weak var errorPassLbl: UILabel!
    @IBOutlet weak var enterBtn: UIButton!
    
    private var isValidPassword = false
    private var isValidEmail = false
    private var isConfPass = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
    }
    
    // MARK: - Actions
    
    @IBAction func emailTFChanged(_ sender: UITextField) {
        guard let email = emailTF.text else { return }
        isValidEmail = VerificationService.isValidEmail(email: email)
        errorEmailLbl.isHidden = isValidEmail
    }
    
    @IBAction func passTFChanged(_ sender: UITextField) {
        guard let pass = passwordTF.text else { return }
        errorPassLbl.isHidden = isValidPassword
    }
    
    @IBAction func signInBtnChanged(_ sender: UIButton) {
        let email = emailTF.text!
        let pass = passwordTF.text!
        
        if (!email.isEmpty && !pass.isEmpty) {
            Auth.auth().signIn(withEmail: email, password: pass) { result, error in
                if error == nil {
                    self.dismiss(animated: true)
                } else {
                    let storyboard = UIStoryboard(name: "Test", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "TestViewController") as! TestViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    @IBAction func goBackToRegistration(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}
