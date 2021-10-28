//
//  SignUpView.swift
//  CustomLoginDemoFirebase
//
//  Created by Saša Brezovac on 27.10.2021..
//

import Foundation
import UIKit

class LoginView: UIView {
    private lazy var stackView = UIStackView()
    private lazy var emailTextField = UITextField()
    private lazy var passwodTextField = UITextField()
    private lazy var loginButton = UIButton(type: .system)
    private lazy var signUpButton = UIButton(type: .system)
    
    var onLoginTapped: (() -> Void)?
    var onSignUpTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func setupView() {
        self.backgroundColor = .lightGray
        
        stackView.backgroundColor = .white
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.layer.cornerRadius = 25.0
        self.addSubview(stackView)
        
        Utilities.styleTextField(emailTextField)
        emailTextField.placeholder = "email"
        stackView.addSubview(emailTextField)
        
        Utilities.styleTextField(passwodTextField)
        passwodTextField.placeholder = "password"
        stackView.addSubview(passwodTextField)
        
        Utilities.styleFilledButton(loginButton)
        loginButton.setTitle("Login", for: .normal)
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        stackView.addSubview(loginButton)
        
        Utilities.styleHollowButton(signUpButton)
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        self.addSubview(signUpButton)
    }
    
    private func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwodTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            stackView.heightAnchor.constraint(equalToConstant: 300),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            emailTextField.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 50),
            emailTextField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 30),
            emailTextField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30),
            
            passwodTextField.heightAnchor.constraint(equalToConstant: 50),
            passwodTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 0),
            passwodTextField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 30),
            passwodTextField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30),
            
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -50),
            loginButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 30),
            loginButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30),
            
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
            signUpButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -25),
            signUpButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 60),
            signUpButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -75),
        ])
    }
    
    @objc func loginTapped() {
        onLoginTapped?()
    }
    
    @objc func signUpTapped() {
        onSignUpTapped?()
    }
    
}
