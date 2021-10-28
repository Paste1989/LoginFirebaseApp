//
//  HomeViewController.swift
//  CustomLoginDemoFirebase
//
//  Created by Saša Brezovac on 28.10.2021..
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    private lazy var homeView = HomeView()
    var viewModel: HomeViewModel!
    
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addCallbacks()
    }
    
    private func addCallbacks() {
        homeView.onLogoutTapped = { [weak self] in
            self?.viewModel.onLogout?()
        }
    }
}
