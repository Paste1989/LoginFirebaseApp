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
    
    var onUserCreated: ((User) -> Void)?
    
    func start() -> UIViewController {
        let vc = createSignUpVC()
        navigationController.pushViewController(vc, animated: true)
        return navigationController
    }
    
    
    private func createSignUpVC() -> UIViewController {
        let vc = SignUpViewController()
        vc.viewModel = SignUpViewModel(firebaseService: ServiceFactory.firebaseService)
        
        vc.viewModel.onUserCreated = { [weak self] currentUser in
            self?.onUserCreated?(currentUser)
        }
        
        return vc
    }
}
