//
//  SignUpCoordinator.swift
//  CustomLoginDemoFirebase
//
//  Created by Saša Brezovac on 27.10.2021..
//

import Foundation
import UIKit

class SignUpCoordinator: Coordinator {
    let navigationController = UINavigationController()
    
    var onRegister: (() -> Void)?
    
    func start() -> UIViewController {
        let vc = createSignUpVC()
        navigationController.pushViewController(vc, animated: true)
        return navigationController
    }
    
    
    private func createSignUpVC() -> UIViewController {
        let vc = SignUpViewController()
        vc.viewModel = SignUpViewModel()
        
        vc.viewModel.onRegister = { [weak self] in
            self?.onRegister?()
        }
        
        return vc
    }
}
