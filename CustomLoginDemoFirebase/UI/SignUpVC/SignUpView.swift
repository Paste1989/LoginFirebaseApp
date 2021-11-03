//
//  LoginView.swift
//  CustomLoginDemoFirebase
//
//  Created by Saša Brezovac on 27.10.2021..
//

import Foundation
import UIKit

class SignUpView: UIView {
    private lazy var stackView = UIStackView()
    private lazy var firstNameTextfield = UITextField()
    private lazy var lastNameTextField = UITextField()
    private lazy var emailTextField = UITextField()
    private lazy var passwodTextField = UITextField()
    private lazy var registerButton = UIButton(type: .system)
    
    var onRegisterTapped: ((User) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func setupView() {
        firstNameTextfield.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        passwodTextField.delegate = self
        
        self.backgroundColor = .lightGray
        
        stackView.backgroundColor = .white
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.layer.cornerRadius = 25.0
        self.addSubview(stackView)
        
        firstNameTextfield.styleTextField()
        firstNameTextfield.placeholder = "first name"
        firstNameTextfield.textColor = UIColor.black
        stackView.addSubview(firstNameTextfield)
        
        lastNameTextField.styleTextField()
        lastNameTextField.placeholder = "last name"
        lastNameTextField.textColor = UIColor.black
        stackView.addSubview(lastNameTextField)
        
        emailTextField.styleTextField()
        emailTextField.placeholder = "email"
        emailTextField.textColor = UIColor.black
        stackView.addSubview(emailTextField)
        
        passwodTextField.styleTextField()
        passwodTextField.placeholder = "password"
        passwodTextField.textColor = UIColor.black
        stackView.addSubview(passwodTextField)
        
        registerButton.styleFilledButton()
        registerButton.setTitle("Register", for: .normal)
        registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        self.addSubview(registerButton)
    }
    
    private func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        firstNameTextfield.translatesAutoresizingMaskIntoConstraints = false
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwodTextField.translatesAutoresizingMaskIntoConstraints = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            stackView.heightAnchor.constraint(equalToConstant: 300),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),

            firstNameTextfield.heightAnchor.constraint(equalToConstant: 50),
            firstNameTextfield.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 50),
            firstNameTextfield.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 30),
            firstNameTextfield.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30),
           
            lastNameTextField.heightAnchor.constraint(equalToConstant: 50),
            lastNameTextField.topAnchor.constraint(equalTo: firstNameTextfield.bottomAnchor, constant: 0),
            lastNameTextField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 30),
            lastNameTextField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30),
            
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            emailTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 0),
            emailTextField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 30),
            emailTextField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30),
            
            passwodTextField.heightAnchor.constraint(equalToConstant: 50),
            passwodTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 0),
            passwodTextField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 30),
            passwodTextField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30),
            
            registerButton.heightAnchor.constraint(equalToConstant: 50),
            registerButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -25),
            registerButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 60),
            registerButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -75),
        ])
    }
    
    @objc func registerTapped() {
        if let firstName = firstNameTextfield.text, let lastName = lastNameTextField.text, let email = emailTextField.text, let password = passwodTextField.text {
            let user = User(firstName: firstName, lastName: lastName, email: email, password: password)
            onRegisterTapped?(user)
        }
    }
}

extension SignUpView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
