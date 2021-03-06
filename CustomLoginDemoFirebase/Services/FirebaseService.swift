//
//  SignUpService.swift
//  CustomLoginDemoFirebase
//
//  Created by Saša Brezovac on 28.10.2021..
//

import Foundation
import FirebaseAuth
import Firebase

protocol FirebaseServiceProtocol {
    var onSuccess: (() -> Void)? { get set}
    var onSuccessData: ((User) -> Void)? { get set }
    var onError: ((String) -> Void)? { get set}
    func createUser(firstName: String, lastName: String, email: String, password: String)
    func login(_ user: User)
    func getData()
}

class FirebaseService: FirebaseServiceProtocol {
    var onSuccess: (() -> Void)?
    var onSuccessData: ((User) -> Void)?
    var onError: ((String) -> Void)?
    
    func createUser(firstName: String, lastName: String, email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                self.onError?("Error creating user.")
            }
            else {
                if let uid = result?.user.uid {
                let dataBase = Firestore.firestore()
                    dataBase.collection("users").addDocument(data: ["firstName": firstName, "lastName": lastName, "uid": uid]) { error in
                        if error != nil {
                            self.onError?("Error saving user data.")
                        }
                        else {
                            self.onSuccess?()
                        }
                    }
                }
            }
        }
    }
    
    func login(_ user: User) {
        Auth.auth().signIn(withEmail: user.email, password: user.password) { result, error in
            if error != nil {
                self.onError?("Wrong email or pasword")
            }
            else {
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                UserDefaults.standard.synchronize()
                self.onSuccess?()
            }
        }
    }
    
    func getData() {
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
                            
                            self.onSuccessData?(currentUser)
                        }
                    }
                }
            }
            else {
                self.onError?("Something went wrong with user data fetching.")
            }
        }
    }
}
