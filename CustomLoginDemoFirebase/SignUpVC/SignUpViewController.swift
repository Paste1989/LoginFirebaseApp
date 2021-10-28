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
    var viewModel: SignUpViewModel!
    
    override func loadView() {
        view = signUpView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCallbacks()
    }
    
    private func addCallbacks() {
        signUpView.onRegisterTapped = { [weak self] in
            self?.viewModel.onRegister?()
        }
    }
}
