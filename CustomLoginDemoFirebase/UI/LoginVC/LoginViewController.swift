//
//  LoginViewController.swift
//  CustomLoginDemoFirebase
//
//  Created by Saša Brezovac on 28.10.2021..
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    private lazy var loginView = LoginView()
    var viewModel: LoginViewModel!
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addCallbacks()
    }
    
    private func addCallbacks() {
        loginView.onLoginTapped = { [weak self] currentUser in
            self?.viewModel.onLogin?(currentUser)
            
        }
        loginView.onSignUpTapped = { [weak self] in
            self?.viewModel.onSignUp?()
        }
    }
}
