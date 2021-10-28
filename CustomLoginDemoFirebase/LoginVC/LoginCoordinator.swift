//
//  LoginCoordinator.swift
//  CustomLoginDemoFirebase
//
//  Created by Saša Brezovac on 27.10.2021..
//

import Foundation
import UIKit

class LoginCoordinator: Coordinator {
    let navigationController = UINavigationController()
    
    var onLoggedIn: (() -> Void)?
    
    func start() -> UIViewController {
        let vc = createLoginVC()
        navigationController.pushViewController(vc, animated: true)
        
        return navigationController
    }
    
    
    private func createLoginVC() -> UIViewController {
        let vc = LoginViewController()
        vc.viewModel = LoginViewModel()
        
        vc.viewModel.onLogin = { [weak self] in
            self?.onLoggedIn?()
        }
        
        vc.viewModel.onSignUp = { [weak self] in
            let vc = SignUpViewController()
            vc.viewModel = SignUpViewModel()
            self?.navigationController.pushViewController(vc, animated: true)
            
            vc.viewModel.onRegister = {
                self?.navigationController.popViewController(animated: true)
            }
        }
        
        return vc
    }
}
