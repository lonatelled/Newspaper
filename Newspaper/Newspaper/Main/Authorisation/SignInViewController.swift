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
    
    var signUp = UIViewController(nibName: "SignUpViewController", bundle: nil)
    var service = Service.shared
    var tapGest: UITapGestureRecognizer?
    var checkField = CheckField.shared
    var userDefaults = UserDefaults.standard

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var errorEmailLbl: UILabel!
    @IBOutlet weak var errorPassLbl: UILabel!
    @IBOutlet weak var enterBtn: UIButton!
    @IBOutlet weak var mainView: UIImageView!
    
    private var isValidPassword = false
    private var isValidEmail = false
    private var isConfPass = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = false
        tapGest = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        mainView.addGestureRecognizer(tapGest!)
    }
    
    // MARK: - Actions
    
    @objc func endEditing() {
        self.view.endEditing(true)
    }
    
    @IBAction func emailTFChanged(_ sender: UITextField) {
    }
   
    @IBAction func passTFChanged(_ sender: UITextField) {
    }
    
    @IBAction func signInBtnChanged(_ sender: UIButton) {
        if checkField.validField(emailView, emailTF), checkField.validField(passwordView, passwordTF) {
            let authData = LoginField(email: emailTF.text!, password: passwordTF.text!)
            service.authInApp(authData) { [weak self] responce in
                switch responce {
                case .success:
                    print("next")
                    self?.userDefaults.set(true, forKey: "isLogin")
                    
                case .noVerify:
                    let alert = AlertService.shared.alertAction("Error", "Вы не верифицировали свой email. На вашу почту отправлена ссылка для верификации!")
                    let okBtn = UIAlertAction(title: "Ok", style: .default)
                    alert.addAction(okBtn)
                    self?.present(alert, animated: true)
                case .error:
                    let alert = AlertService.shared.alertAction("Error", "Email или пароль не подходят")
                    let okBtn = UIAlertAction(title: "Ok", style: .default)
                    alert.addAction(okBtn)
                    self?.present(alert, animated: true)
                }
            }
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "OnboardingViewController")
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let alert = AlertService.shared.alertAction("Error", "Проверьте введённые данные")
            let okBtn = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okBtn)
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func goBackToRegistration(_ sender: UIButton) {
    }
    
    
    
}
