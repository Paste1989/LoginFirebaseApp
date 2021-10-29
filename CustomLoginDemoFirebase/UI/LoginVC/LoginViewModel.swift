//
//  LoginViewModel.swift
//  CustomLoginDemoFirebase
//
//  Created by Saša Brezovac on 27.10.2021..
//

import Foundation
import FirebaseAuth
import Firebase

class LoginViewModel {
    var onStartActivity: (() -> Void)?
    var onEndActivity: (() -> Void)?
    var onLoginSuccess: ((User) -> Void)?
    var onSignUp: (() -> Void)?
    var onError: ((String) -> Void)?
    
    var firebaseService: FirebaseServiceProtocol
    var connectivityService: ConnectivityServiceProtcol
    init(firebaseService: FirebaseServiceProtocol, connectivityService: ConnectivityServiceProtcol) {
        self.firebaseService = firebaseService
        self.connectivityService = connectivityService
    }
    
    func login(_ user: User) {
        onStartActivity?()
        firebaseService.login(user)
        firebaseService.onSuccess = { [weak self] in
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            UserDefaults.standard.synchronize()
            self?.getUserData()
        }
        firebaseService.onError = { [weak self] errorMessage in
            self?.onError?(errorMessage)
            self?.onEndActivity?()
        }
    }
    
    private func getUserData() {
        firebaseService.getData()
        firebaseService.onSuccessData = { [weak self] currentUser in
            self?.onLoginSuccess?(currentUser)
            self?.onEndActivity?()
        }
        firebaseService.onError = { [weak self] errorMessage in
            self?.onError?(errorMessage)
            self?.onEndActivity?()
        }
    }
}


