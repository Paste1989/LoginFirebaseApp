//
//  ServiceFactory.swift
//  CustomLoginDemoFirebase
//
//  Created by Saša Brezovac on 28.10.2021..
//

import Foundation

class ServiceFactory {
    static let connectivityService: ConnectivityServiceProtcol = {
        return ConnectivityService()
    }()
    
    static let firebaseService: FirebaseServiceProtocol = {
        return FirebaseService()
    }()
}
