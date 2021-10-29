//
//  File.swift
//  CustomLoginDemoFirebase
//
//  Created by Saša Brezovac on 29.10.2021..
//

import Foundation
import Alamofire

protocol ConnectivityServiceProtcol {
    var isConneced: Bool { get }
}

class ConnectivityService: ConnectivityServiceProtcol {
    private var networkManager = NetworkReachabilityManager()
    
    var isConneced: Bool {
        return networkManager?.isReachable ?? false
    }
    
    
}
