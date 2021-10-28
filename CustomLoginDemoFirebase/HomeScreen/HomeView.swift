//
//  HomeView.swift
//  CustomLoginDemoFirebase
//
//  Created by Saša Brezovac on 28.10.2021..
//

import Foundation
import UIKit

class HomeView: UIView {
    private lazy var messageLabel = UILabel()
    private lazy var logoutButton = UIButton(type: .system)
    
    var onLogoutTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = .white
        
        messageLabel.text = "Logged in successfully!"
        messageLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        messageLabel.textColor = .black
        self.addSubview(messageLabel)
        
        Utilities.styleFilledButton(logoutButton)
        logoutButton.setTitle("Log Out", for: .normal)
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        self.addSubview(logoutButton)
    }
    
    private func setupConstraints() {
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            messageLabel.heightAnchor.constraint(equalToConstant: 50),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            
            logoutButton.heightAnchor.constraint(equalToConstant: 50),
            logoutButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -75),
            logoutButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 60),
            logoutButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -60)
        ])
    }
   
    @objc func logoutTapped() {
        onLogoutTapped?()
    }
    
}
