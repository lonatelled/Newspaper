//
//  AuthViewController.swift
//  Newspaper
//
//  Created by Дарья Каркоцкая on 8.05.22.
//

import UIKit
import Firebase

class AuthViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var secondPassField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var errorLblName: UILabel!
    @IBOutlet weak var errorLblEmail: UILabel!
    @IBOutlet weak var errorLblPass: UILabel!
    @IBOutlet weak var errorLblSecondPass: UILabel!
    
    private var isValidEmail = false
    private var isConfPass = false
    private var isValidFullname = false
    private var passwordStrength: PasswordStrength = .veryWeak
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func fullnameTFChanged(_ sender: UITextField) {
        guard let fullname = sender.text else { return }
        isValidFullname = VerificationService.isValidFullname(fullname: fullname)
        errorLblName.isHidden = isValidFullname
        updateBtnState()
    }
    
    @IBAction func emailTFChanged(_ sender: UITextField) {
        guard let email = sender.text else { return }
        isValidEmail = VerificationService.isValidEmail(email: email)
        errorLblEmail.isHidden = isValidEmail
        updateBtnState()
    }
    
    @IBAction func passTFChanged(_ sender: UITextField) {
        guard let pass1 = sender.text else { return }
        passwordStrength = VerificationService.isValidPassword(pass: pass1)
        errorLblPass.isHidden = !(passwordStrength == .veryWeak)
        
        guard let pass2 = secondPassField.text else { return }
        updatePassErrorLbl(pass1: pass1, pass2: pass2)
        
        updateBtnState()
    }
    
    @IBAction func confPassTFChanged(_ sender: UITextField) {
        guard let pass1 = passwordField.text,
              let pass2 = sender.text else { return }
        updatePassErrorLbl(pass1: pass1, pass2: pass2)
        updateBtnState()
    }

    private func updatePassErrorLbl(pass1: String, pass2: String) {
    isConfPass = VerificationService.isPassCofirm(pass1: pass1, pass2: pass2)
    errorLblSecondPass.isHidden = isConfPass
    }
    
    private func updateBtnState() {
        enterButton.isEnabled = isValidEmail &&
            isConfPass && (passwordStrength != .veryWeak)
    }
    
    @IBAction func swithLogin(_ sender: UIButton) {
        let name = nameField.text!
        let email = emailField.text!
        let password = passwordField.text!
        
        if (!name.isEmpty && !email.isEmpty && !password.isEmpty) {
            if name.count >= 3, password.count >= 8 {
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    if error == nil {
                        if let result = result {
                            print(result.user.uid)
                            let ref = Database.database().reference().child("users")
                            ref.child(result.user.uid).updateChildValues(["name": name, "email" : email])
                            
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                }
            }
        }
    }
}
