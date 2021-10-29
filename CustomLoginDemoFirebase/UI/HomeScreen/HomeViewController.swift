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
    
    var user: User
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCallbacks()
    }
    
    private func addCallbacks() {
        homeView.updateView(message: user.firstName + " " + user.lastName)
        homeView.onLogoutTapped = { [weak self] in
            self?.viewModel.onLogout?()
        }
    }
}
