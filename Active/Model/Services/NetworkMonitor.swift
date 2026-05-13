//
//  NetworkMonitor.swift
//  Active
//
//  Created by Yomna on 12/05/2026.
//

import Foundation
import Network

class NetworkMonitor {

    static let shared = NetworkMonitor()

    private let monitor = NWPathMonitor()

    private var isConnected = true

    private init() {

        monitor.pathUpdateHandler = { path in

            self.isConnected =
            path.status == .satisfied
        }

        let queue = DispatchQueue(label: "NetworkMonitor")

        monitor.start(queue: queue)
    }

    func checkConnection() -> Bool {

        return isConnected
    }
}

