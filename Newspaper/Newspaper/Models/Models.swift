//
//  UserModel.swift
//  Newspaper
//
//  Created by Дарья Каркоцкая on 22.05.22.
//

import Foundation

enum AuthResponce {
    case success, noVerify, error
}

struct User {
    
    var fullname: String!
    var email: String!
    var profileImage: String!
    var uid: String!
    
    init(dictionary: [String: Any]) {
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.profileImage = dictionary["profileImage"] as? String ?? ""
        self.uid = dictionary["profileImage"] as? String ?? ""

    }
}

struct LoginField {
    var email: String
    var name: String?
    var password: String
}

struct ResponseCode {
    
    var code: Int
    
}

