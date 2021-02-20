//
//  LoginModel.swift
//  ScreenTest
//
//  Created by Harshad Medisage on 20/02/21.
//

import Foundation

class LoginModel {
    
    var email = ""
    var password = ""
    
    convenience init(email : String, password : String) {
        self.init()
        self.email = email
        self.password = password
    }
}
