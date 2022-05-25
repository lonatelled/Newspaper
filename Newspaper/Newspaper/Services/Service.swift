//
//  Firebase.swift
//  Newspaper
//
//  Created by Дарья Каркоцкая on 22.05.22.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import UIKit

class Service {
        
    static let shared = Service()
    
    init() {}
    
    let ref = Firestore.firestore()
    
    func createNewUser(_ data: LoginField, completion: @escaping (ResponseCode) -> ()) {
        Auth.auth().createUser(withEmail: data.email, password: data.password) { [weak self] result, err in
            if err != nil {
                let responseError = err! as NSError
                switch responseError.code {
                case AuthErrorCode.emailAlreadyInUse.rawValue:
                    completion(ResponseCode(code: 0))
                default:
                    print("Неизвестная ошибка: \(responseError.localizedDescription)")
                }
            } else {
                if result != nil {
                    let userId = result?.user.uid
                    let userData: [String: Any] = ["name": data.name!, "email": data.email]
                    self?.ref.collection("users").document(userId!).setData(userData, completion: { error in
                        if error == nil {
                            completion(ResponseCode(code: 1))
                        } else {
                            completion(ResponseCode(code: 0))
                        }
                    })
                }
                completion(ResponseCode(code: 0))
            }
        }
    }
    
    func confirmEmail() {
        Auth.auth().currentUser?.sendEmailVerification(completion: { err in
            if err != nil {
                print(err!.localizedDescription)
            }
        })
    }
    
    func authInApp(_ data: LoginField, completion: @escaping (AuthResponce) -> ()) {
        Auth.auth().signIn(withEmail: data.email, password: data.password) { result, err in
            if err != nil {
                completion(.error)
            } else {
                if let result = result {
                    if result.user.isEmailVerified {
                        completion(.success)
                    } else {
                        self.confirmEmail()
                        completion(.noVerify)
                    }
                }
            }
        }
    }
}
