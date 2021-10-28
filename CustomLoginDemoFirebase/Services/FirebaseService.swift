//
//  SignUpService.swift
//  CustomLoginDemoFirebase
//
//  Created by Saša Brezovac on 28.10.2021..
//

import Foundation
import FirebaseAuth
import Firebase

protocol FirebaseProtocol {
    var onSuccess: (() -> Void)? { get set}
    var onError: ((String) -> Void)? { get set}
    func createUser(firstName: String, lastName: String, email: String, password: String)
}

class FirebaseService: FirebaseProtocol {
    var onSuccess: (() -> Void)?
    var onError: ((String) -> Void)?
    
    func createUser(firstName: String, lastName: String, email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                self.onError?("Error creating user.")
                print("Error creating user: \(String(describing: error))")
            }
            else {
                if let uid = result?.user.uid {
                let dataBase = Firestore.firestore()
                    dataBase.collection("users").addDocument(data: ["firstName": firstName, "lastName": lastName, "uid": uid]) { error in
                        if error != nil {
                            self.onError?("Error saving user data.")
                            print("Error saving user data.")
                        }
                        else {
                            self.onSuccess?()
                        }
                    }
                }
            }
        }
    }
}
