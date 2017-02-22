//
//  AuthenticationModel.swift
//  Jobsity Challenge
//
//  Created by Camilo Medina on 2/21/17.
//  Copyright © 2017 Jobsity. All rights reserved.
//

import Foundation
import SmileLock

class AuthenticationModel {
    class func match(_ password: String) -> AuthenticationModel? {
        if UserDefaults.standard.bool(forKey: "passwordAlreadySet") {
            let passcode = UserDefaults.standard.string(forKey: "passcode")
            guard password == passcode else { return nil }
            return AuthenticationModel()
        } else {
            UserDefaults.standard.set(password,forKey: "passcode")
            UserDefaults.standard.set(true,forKey: "passwordAlreadySet")
            return AuthenticationModel()
        }
        
    }
}

class AuthenticationUIValidation: PasswordUIValidation<AuthenticationModel> {
    init(in stackView: UIStackView, passwordDigits digits: Int) {
        super.init(in: stackView, digit: digits)
        validation = { password in
            AuthenticationModel.match(password)
        }
    }
    
    //handle Touch ID
    override func touchAuthenticationComplete(_ passwordContainerView: PasswordContainerView, success: Bool, error: NSError?) {
        if success {
            let dummyModel = AuthenticationModel()
            self.success?(dummyModel)
        } else {
            passwordContainerView.clearInput()
        }
    }
}
