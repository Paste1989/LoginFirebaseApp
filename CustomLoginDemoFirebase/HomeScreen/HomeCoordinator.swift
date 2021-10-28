//
//  HomeCoordinator.swift
//  CustomLoginDemoFirebase
//
//  Created by Saša Brezovac on 28.10.2021..
//

import Foundation
import UIKit

class HomeCoordinator: Coordinator {
    let navigationController = UINavigationController()
    
    var onLogoutSuccess: (() -> Void)?
    
    func start() -> UIViewController {
        let vc = createHomeVC()
        navigationController.pushViewController(vc, animated: true)
        
        return navigationController
    }
    
    private func createHomeVC() -> UIViewController {
        let vc = HomeViewController()
        vc.viewModel = HomeViewModel()
        
        vc.viewModel.onLogout = { [weak self] in
            self?.onLogoutSuccess?()
        }
        
        return vc
    }
}
