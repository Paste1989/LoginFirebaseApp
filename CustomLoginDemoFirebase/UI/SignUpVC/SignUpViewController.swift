//
//  SignUpViewController.swift
//  CustomLoginDemoFirebase
//
//  Created by Saša Brezovac on 27.10.2021..
//

import Foundation
import UIKit

class SignUpViewController: UIViewController {
    private lazy var signUpView = SignUpView()
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.color = .darkGray
        self.view.addSubview(indicator)
        indicator.center = view.center
        return indicator
    }()
    var viewModel: SignUpViewModel!
    
    override func loadView() {
        view = signUpView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCallbacks()
    }
    
    private func addCallbacks() {
        signUpView.onRegisterTapped = { [weak self] user in
            self?.viewModel.checkForErrorsAndCreateUser(user)
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
