//
//  HomeViewModel.swift
//  CustomLoginDemoFirebase
//
//  Created by Saša Brezovac on 28.10.2021..
//

import Foundation
import Firebase
import FirebaseAuth

class HomeViewModel {
    var onLogout: (() -> Void)?
    
    var ref: DatabaseReference!
    
    func logout() {
        if Auth.auth().currentUser?.uid != nil {
            do {
                try Auth.auth().signOut()
                UserDefaults.standard.set(false, forKey: "isLoggedIn")
                UserDefaults.standard.synchronize()
                onLogout?()
            }
            catch let logoutError {
                print("Error with loggin out: \(logoutError)")
            }
            
        }
    }
}
