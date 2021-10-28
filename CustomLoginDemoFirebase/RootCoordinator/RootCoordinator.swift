//
//  RootCoordinator.swift
//  CustomLoginDemoFirebase
//
//  Created by Saša Brezovac on 27.10.2021..
//

import Foundation
import UIKit

class RootCoordinator: Coordinator {
    let navigationController = UINavigationController()
    var childCoordinator: Coordinator?
    
    func start() -> UIViewController {
        let vc = setLoginCoordinatorAsRoot()
        
        return vc
    }
    
    private func setLoginCoordinatorAsRoot() -> UIViewController {
        let loginCoordinator = LoginCoordinator()
        childCoordinator = loginCoordinator
        let rootVC = loginCoordinator.start()
        UIApplication.shared.windows.first?.rootViewController = rootVC
        
        loginCoordinator.onLoggedIn = { [weak self] in
            _ = self?.setHomeCoordinatorAsRoot()
        }
       
        return rootVC
    }
    
    private func setHomeCoordinatorAsRoot() -> UIViewController {
        let homeCoordinator = HomeCoordinator()
        childCoordinator = homeCoordinator
        let rootVC = homeCoordinator.start()
        UIApplication.shared.windows.first?.rootViewController = rootVC
       
        homeCoordinator.onLogoutSuccess = { [weak self] in
            _ = self?.setLoginCoordinatorAsRoot()
        }
        
        return rootVC
    }
}
