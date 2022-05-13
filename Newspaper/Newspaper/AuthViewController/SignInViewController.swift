//
//  SignInViewController.swift
//  Newspaper
//
//  Created by Дарья Каркоцкая on 8.05.22.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {

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
    
    @IBAction func emailTFChanged(_ sender: UITextField) {
        guard let email = emailTF.text else { return }
        isValidEmail = VerificationService.isValidEmail(email: email)
        errorEmailLbl.isHidden = isValidEmail
        updateBtnState()
    }
    
    @IBAction func passTFChanged(_ sender: UITextField) {
        guard let pass = passwordTF.text else { return }
//        _ = VerificationService.isValidPassword(pass: pass)
        errorPassLbl.isHidden = isValidPassword
//        updateBtnState()
    }
    
    @IBAction func signInBtnChanged(_ sender: UIButton) {
        let email = emailTF.text!
        let password = passwordTF.text!
        
        if (!email.isEmpty && !password.isEmpty) {
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if error == nil {
                    if let result = result {
                        print(result.user.uid)
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                        self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
        
        
        
//        guard let email = emailTF.text else { return }
//        guard let pass = passwordTF.text else { return }
//
//        Auth.auth().signIn(withEmail: email, password: pass) { user, error in
//            print(user?.user.uid)
//
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
//            self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func goBackToRegistration(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func updateBtnState() {
        enterBtn.isEnabled = isValidEmail && isConfPass
    }
    
    
    // MARK: - Navigation

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//    }
}
