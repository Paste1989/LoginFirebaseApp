//
//  SignUpViewModel.swift
//  CustomLoginDemoFirebase
//
//  Created by Saša Brezovac on 27.10.2021..
//

import Foundation
import UIKit
import FirebaseAuth
import Firebase

class SignUpViewModel {
    var onUserCreated: ((User) -> Void)?
    var onError: ((String) -> Void)?
    
    var firebaseService: FirebaseProtocol
    init(firebaseService: FirebaseProtocol) {
        self.firebaseService = firebaseService
    }
    
    func checkForErrorsAndCreateUser(firstName: String, lastName: String, email: String, password: String) {
        if let validationError = validateFields(firstName, lastName, email, password) {
            onError?(validationError)
        }
        else {
            firebaseService.createUser(firstName: firstName, lastName: lastName, email: email, password: password)
            firebaseService.onSuccess = { [weak self] in
                let currentUser = User(firstName: firstName, lastName: lastName, email: email, password: password)
                self?.onUserCreated?(currentUser)
            }
            firebaseService.onError = { [weak self] errorMessage in
                self?.onError?(errorMessage)
            }
        }
    }
    
    private func validateFields(_ firstName: String, _ lastName: String, _ email: String, _ password: String) -> String? {
        if firstName.trimmingCharacters(in: .whitespaces) == "" ||
            lastName.trimmingCharacters(in: .whitespaces) == "" ||
            email.trimmingCharacters(in: .whitespaces) == "" ||
            password.trimmingCharacters(in: .whitespaces) == "" {
            return "Please fill in all fields."
        }
        
        let password = password.trimmingCharacters(in: .whitespacesAndNewlines)
        if !isPasswordValid(password) {
            return "Please make sure your password is at least 8 characters, contsains a special character and a number."
        }
        return nil
    }
    
    
    private func isPasswordValid(_ password: String) -> Bool {
        let passwordTest = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordTest).evaluate(with: password)
    }
}
