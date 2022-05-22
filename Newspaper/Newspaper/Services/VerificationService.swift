//
//  VerificationService.swift
//  Newspaper
//
//  Created by Дарья Каркоцкая on 8.05.22.
//

import Foundation

// MARK: — Password strenght

enum PasswordStrength: Int {
    case veryWeak
    case weak
    case notVeryWeak
    case notVeryStrong
    case strong
}

// MARK: — Verification service

final class VerificationService {
    
    static let weakRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
    static let notVeryWeakRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"
    static let notVeryStrongRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
    static let strongRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}"
    
    static func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    static func isValidFullname(fullname: String) -> Bool {
        let fullnameRegEx = "[A-Z0-9a-z._%+-]+[A-Za-z0-9.-]{3,18}"
        let fullnamePred = NSPredicate(format:"SELF MATCHES %@", fullnameRegEx)
        return fullnamePred.evaluate(with: fullname)
    }
    
    static func isValidPassword(pass: String) -> PasswordStrength {
        if NSPredicate(format: "SELF MATCHES %@", strongRegex).evaluate(with: pass) {
            return .strong
        } else if NSPredicate(format: "SELF MATCHES %@", notVeryStrongRegex).evaluate(with: pass) {
            return .notVeryStrong
        } else if NSPredicate(format: "SELF MATCHES %@", notVeryWeakRegex).evaluate(with: pass) {
            return .notVeryWeak
        } else if NSPredicate(format: "SELF MATCHES %@", weakRegex).evaluate(with: pass) {
            return .weak
        } else {
            return .veryWeak
        }
    }
    
    static func isPassCofirm(pass1: String, pass2: String) -> Bool {
        return pass1 == pass2
    }
}
