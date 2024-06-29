//
//  NetworkManager.swift
//  DemoProject
//
//  Created by Bobby Dotiyal on 29/06/24.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private let reachabilityManager = NetworkReachabilityManager()

    func isNetworkAvailable() -> Bool {
        return reachabilityManager?.isReachable ?? false
    }
    
    func startMonitoring() {
        reachabilityManager?.startListening { status in
            switch status {
            case .notReachable:
                print("The network is not reachable")
            case .unknown:
            
                print("It is unknown whether the network is reachable")
            case .reachable(.ethernetOrWiFi):
                print("The network is reachable over the WiFi connection")
            case .reachable(.cellular):
                print("The network is reachable over the cellular connection")
            }
        }
    }
    
    func stopMonitoring() {
        reachabilityManager?.stopListening()
    }
}
