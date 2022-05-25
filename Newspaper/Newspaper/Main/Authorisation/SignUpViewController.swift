//
//  ViewController.swift
//  Newspaper
//
//  Created by Дарья Каркоцкая on 7.05.22.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

final class SignUpViewController: UIViewController {
    
    // MARK: - Outlets
    
    var tapGest: UITapGestureRecognizer?
    var checkField = CheckField.shared
    var service = Service.shared
    var isValid = false
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var secondPassField: UITextField!
    @IBOutlet weak var secondPassView: UIView!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var errorLblName: UILabel!
    @IBOutlet weak var errorLblEmail: UILabel!
    @IBOutlet weak var errorLblPass: UILabel!
    @IBOutlet weak var errorLblSecondPass: UILabel!
    @IBOutlet weak var mainView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGest = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        mainView.addGestureRecognizer(tapGest!)
        swithLogin(enterButton)
    }
    
    // MARK: - Actions
    
    @objc func endEditing() {
        self.view.endEditing(true)
    }
    
    @IBAction func fullnameTFChanged(_ sender: UITextField) {
        if checkField.validField(nameView, nameField) {
            errorLblName.isHidden = true
        } else {
            errorLblName.isHidden = false
        }
    }

    @IBAction func emailTFChanged(_ sender: UITextField) {
        if checkField.validField(emailView, emailField) {
            errorLblEmail.isHidden = true
        } else {
            errorLblEmail.isHidden = false
        }
    }
    
    @IBAction func passTFChanged(_ sender: UITextField) {
        if checkField.validField(passwordView, passwordField) {
            errorLblPass.isHidden = true
        } else {
            errorLblPass.isHidden = false
        }
    }

    @IBAction func confPassTFChanged(_ sender: UITextField) {
        if checkField.validField(secondPassView, secondPassField) {
            errorLblSecondPass.isHidden = true
        } else {
            errorLblSecondPass.isHidden = false
        }
    }
    
    @IBAction func swithLogin(_ sender: UIButton) {
        if checkField.validField(emailView, emailField), checkField.validField(nameView, nameField), checkField.validField(passwordView, passwordField) {
            if passwordField.text == secondPassField.text {
                service.createNewUser(LoginField(email: emailField.text!, name: nameField.text!, password: passwordField.text!)) { [weak self] code in
                    switch code.code {
                    case 0:
                        print("Произошла ошибка")
                    case 1:
                        self?.service.confirmEmail()
                        print("Регистрация успешна")
                    default:
                        print("Неизвестная ошибка")
                    }
                }
            } else {
                print("Поля не совпадают")
            }
            let alert = AlertService.shared.alertAction("Регистрация прошла успешна", "На вашу почту отправлена ссылка для верификации аккаунта!")
            let okBtn = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okBtn)
            self.present(alert, animated: true)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
