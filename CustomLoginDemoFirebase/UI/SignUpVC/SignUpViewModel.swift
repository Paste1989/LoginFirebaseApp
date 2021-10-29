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
    var onStartActivity: (() -> Void)?
    var onEndActivity: (() -> Void)?
    var onUserCreated: ((User) -> Void)?
    var onError: ((String) -> Void)?
    
    var firebaseService: FirebaseServiceProtocol
    var connectivityService: ConnectivityServiceProtcol
    init(firebaseService: FirebaseServiceProtocol, connectivityService: ConnectivityServiceProtcol) {
        self.firebaseService = firebaseService
        self.connectivityService = connectivityService
    }
    
    func checkForErrorsAndCreateUser(_ user: User) {
        onStartActivity?()
        if let validationError = validateFields(user.firstName, user.lastName, user.email, user.password) {
            onError?(validationError)
            onEndActivity?()
        }
        else {
            firebaseService.createUser(firstName: user.firstName, lastName: user.lastName, email: user.email, password: user.password)
            firebaseService.onSuccess = { [weak self] in
                let currentUser = User(firstName: user.firstName, lastName: user.lastName, email: user.email, password: user.password)
                self?.onUserCreated?(currentUser)
                self?.onEndActivity?()
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                UserDefaults.standard.synchronize()
            }
            firebaseService.onError = { [weak self] errorMessage in
                self?.onError?(errorMessage)
                self?.onEndActivity?()
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
