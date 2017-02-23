//
//  AuthenticationViewController.swift
//  Jobsity Challenge
//
//  Created by Camilo Medina on 2/21/17.
//  Copyright © 2017 Jobsity. All rights reserved.
//

import UIKit
import SmileLock

class AuthenticationViewController: UIViewController {
    
    @IBOutlet weak var passwordStackView: UIStackView!
    @IBOutlet weak var passwordMessage: UILabel!
    
    var passwordUIValidation: AuthenticationUIValidation!
    let kPasswordDigit = 6

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !UserDefaults.standard.bool(forKey: "passwordAlreadySet") {
            passwordMessage.text = "Please set a passcode"
        }
        
        //create PasswordUIValidation subclass
        passwordUIValidation = AuthenticationUIValidation(in: passwordStackView, passwordDigits: kPasswordDigit)
        passwordUIValidation.success = { [weak self] _ in
            print("Success!")
            self?.dismiss(animated: true, completion: nil)
        }
        
        passwordUIValidation.failure = { _ in
            print("Failure!")
        }
        
        //visual effect password UI
        passwordUIValidation.view.rearrangeForVisualEffectView(in: self)
    }

}
