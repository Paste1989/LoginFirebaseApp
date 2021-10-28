//
//  LoginViewModel.swift
//  CustomLoginDemoFirebase
//
//  Created by Saša Brezovac on 27.10.2021..
//

import Foundation

class LoginViewModel {
    var onLogin: ((User) -> Void)?
    var onSignUp: (() -> Void)?
}
