//
//  LoginViewModel.swift
//  CustomLoginDemoFirebase
//
//  Created by Saša Brezovac on 27.10.2021..
//

import Foundation
import FirebaseAuth
import Firebase

class LoginViewModel {
    var onStartActivity: (() -> Void)?
    var onEndActivity: (() -> Void)?
    var onLoginSuccess: ((User) -> Void)?
    var onSignUp: (() -> Void)?
    var onError: ((String) -> Void)?
    
    func login(_ user: User) {
        onStartActivity?()
        Auth.auth().signIn(withEmail: user.email, password: user.password) { result, error in
            if error != nil {
                self.onError?("Error with user logging in.")
                self.onEndActivity?()
            }
            else {
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                UserDefaults.standard.synchronize()
                self.getUserData()
            }
        }
    }
    
    private func getUserData() {
        let db = Firestore.firestore()
        db.collection("users").getDocuments { (snapshot, error) in
            if error == nil {
                if let snapshot = snapshot {

                    guard let uid = Auth.auth().currentUser?.uid else { return }
                    for document in snapshot.documents {
                        let userUid = document["uid"] as? String ?? ""
                        if userUid == uid {
                            let firstName = document["firstName"] as? String ?? ""
                            let lastName = document["lastName"] as? String ?? ""
                            let email = document["email"] as? String ?? ""
                            let password = document["password"] as? String ?? ""
                            let currentUser = User(firstName: firstName, lastName: lastName, email: email, password: password)
                            
                            self.onLoginSuccess?(currentUser)
                            self.onEndActivity?()
                        }
                    }
                }
            }
            else {
                self.onError?("Something went wrong with user data fetching.")
                self.onEndActivity?()
            }
        }
    }
}


