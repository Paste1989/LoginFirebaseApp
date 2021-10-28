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
    var currentUser: User?
    
    func start() -> UIViewController {
        let vc = setLoginCoordinatorAsRoot()
        
        return vc
    }
    
    private func setLoginCoordinatorAsRoot() -> UIViewController {
        let loginCoordinator = LoginCoordinator()
        childCoordinator = loginCoordinator
        let rootVC = loginCoordinator.start()
        UIApplication.shared.windows.first?.rootViewController = rootVC
        
        loginCoordinator.onLoggedIn = { [weak self] currentUser in
            self?.currentUser = currentUser
            _ = self?.setHomeCoordinatorAsRoot(currentUser)
        }
       
        return rootVC
    }
    
    private func setHomeCoordinatorAsRoot(_ currentUser: User) -> UIViewController {
        let homeCoordinator = HomeCoordinator(user: currentUser)
        childCoordinator = homeCoordinator
                
        let rootVC = homeCoordinator.start()
        UIApplication.shared.windows.first?.rootViewController = rootVC
       
        homeCoordinator.onLogoutSuccess = { [weak self] in
            self?.currentUser = nil
            _ = self?.setLoginCoordinatorAsRoot()
        }
        
        return rootVC
    }
}
