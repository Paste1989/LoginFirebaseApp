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
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.color = .darkGray
        self.view.addSubview(indicator)
        indicator.center = view.center
        return indicator
    }()
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
            self?.viewModel.login(currentUser)
        }
        
        loginView.onSignUpTapped = { [weak self] in
            self?.viewModel.onSignUp?()
        }
        
        viewModel.onStartActivity = { [weak self] in
            self?.activityIndicator.startAnimating()
        }
        
        viewModel.onEndActivity = { [weak self] in
            self?.activityIndicator.stopAnimating()
        }
        
        viewModel.onError = { [weak self] errorMessage in
            self?.showMessage(title: nil, messagae: errorMessage)
        }
    }
}
